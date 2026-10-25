# DataFrame

## Functions

### `.fn.select`

Run a functional select with explicit expressions:

```pepper
.fn.select[table; partitions; where; group; operations; limit]
```

| Parameters | Type              | Description                                      |
| ---------- | ----------------- | ------------------------------------------------ |
| table      | sym or dataframe  | Table to query                                   |
| partitions | list              | Partition values; use an empty list for an in-memory table |
| where      | list of expressions | Filter conditions                              |
| group      | list of expressions | Grouping expressions                           |
| operations | list of expressions | Columns or aggregations to return              |
| limit      | int               | Positive: first rows; negative: last rows; zero: no limit |

Python bindings accept `polars.Expr` in these arguments, including expressions
inside lists and dictionaries. Expressions returned by the engine are also
converted to `polars.Expr`. Expression exchange uses Polars JSON serialization;
expression structures unsupported by either side can raise conversion errors.

```python
import polars as pl
from chili import ChiliEngine

engine = ChiliEngine(pepper=True)
engine.set_var("trades", pl.DataFrame({
    "sym": ["a", "b", "a"],
    "qty": [1, 2, 3],
}))
result = engine.fn_call(
    ".fn.select",
    ["trades", [], [], [pl.col("sym")], [pl.col("qty").sum()], 0],
)
# result contains sym: ["a", "b"], qty: [4, 2]
engine.shutdown()
```

Plain strings and symbols remain literal values. For example, grouping by
`["sym"]` groups by the constant text "sym"; `[pl.col("sym")]` groups by the
column. In Pepper, use `col each ks` to convert a list of names to column
expressions.

### `collect`

Collect a lazy DataFrame into an eager DataFrame. Used with lazy evaluation mode (`-L` or `--lazy`).

| Parameters | Type       | Description                   |
| ---------- | ---------- | ----------------------------- |
| lazy_frame | lazy frame | Lazy DataFrame to collect     |

### `cols`

Get the columns of a dataframe.

| Parameters | Type | Description                   |
| ---------- | ---- | ----------------------------- |
| df         | df   | DataFrame to get columns from |

### `describe`

Get the description of a dataframe.

| Parameters | Type | Description                       |
| ---------- | ---- | --------------------------------- |
| df         | df   | DataFrame to get description from |

### `explode`

Explode a dataframe by a list of rows.

| Parameters | Type | Description          |
| ---------- | ---- | -------------------- |
| df         | df   | DataFrame to explode |
| columns    | list | Columns to explode   |

### `extend`

Extend a dataframe with another dataframe without rechunking.

| Parameters | Type | Description      |
| ---------- | ---- | ---------------- |
| df1        | df   | First dataframe  |
| df2        | df   | Second dataframe |

### `flag`

Check if the sort flag with series.

| Parameters | Type   | Description     |
| ---------- | ------ | --------------- |
| series     | series | Series to check |

### `flip`

Flip a dictionary into a dataframe.

| Parameters | Type | Description        |
| ---------- | ---- | ------------------ |
| dict       | dict | Dictionary to flip |

### `hstack`

Horizontally stack two dataframes.

| Parameters | Type | Description      |
| ---------- | ---- | ---------------- |
| df1        | df   | First dataframe  |
| df2        | df   | Second dataframe |

### `pivot`

Pivot a dataframe.

| Parameters  | Type | Description               |
| ----------- | ---- | ------------------------- |
| df          | df   | DataFrame to pivot        |
| indices     | list | Indices to pivot          |
| on_cols     | list | Columns to pivot          |
| values      | list | Values to pivot           |
| agg_fn_name | sym  | Aggregation function name |

### `schema`

Get the schema of a dataframe.

| Parameters | Type | Description                  |
| ---------- | ---- | ---------------------------- |
| df         | df   | DataFrame to get schema from |

### `transpose`

Transpose a dataframe.

| Parameters | Type | Description            |
| ---------- | ---- | ---------------------- |
| df         | df   | DataFrame to transpose |

### `unique`

Stable row deduplication keeping the first occurrence of each duplicate row.

| Parameters | Type | Description                         |
| ---------- | ---- | ----------------------------------- |
| df         | df   | DataFrame to deduplicate            |

### `unpivot`

Unpivot a dataframe.

| Parameters | Type | Description          |
| ---------- | ---- | -------------------- |
| df         | df   | DataFrame to unpivot |
| indices    | list | Indices to unpivot   |
| on_cols    | list | Columns to unpivot   |

### `vstack`

Append dataframe chunks with `vstack[table; data]` (pepper) or
`vstack(table, data)` (chili).

- `table` is a table symbol or a dataframe value; `data` must be a dataframe.
- A table symbol appends atomically to global state and returns the incoming row
  count. A missing table is created from `data`. Incoming dtypes and timezones
  follow the existing table, as with symbol `upsert`; a failed append preserves
  the table.
- A dataframe value returns a new dataframe without changing either input.

Symbol-form `vstack` preserves the historical buffers held by concurrent readers
or writers. Ordinary `upsert` extends backing storage and may copy retained data
while a snapshot is alive.

Since 0.11.3, symbol-form `vstack` buffers have automatic compaction enabled by
default: a separate Rust worker starts on the first nonempty append, waits
250 ms between passes, and merges small chunks with a 65,536-row target. Existing
large chunks keep their buffers. No Python timer or job scheduler is required.
Only tables changed by symbol-form `vstack` are scheduled; dataframe-value calls
and `set_var` alone do not schedule maintenance.

Use [`.compact.configure`](config.md#compactconfigure) or Python
`engine.set_auto_compaction(interval_ms=250, target_rows=65536)` to tune the
worker. Compaction controls chunk growth, not retention or a hard latency bound.
See [`upsertn`](#upsertn) for the retention tradeoff.

=== "chili"

    ```chili
    t: ([]seq: 1 2);
    added: vstack(`t, ([]seq: 3 4));
    // added is 2; t contains seq: 1 2 3 4
    combined: vstack(t, ([]seq: 5));
    // combined has 5 rows; t still has 4
    ```

=== "pepper"

    ```pepper
    t: ([]seq: 1 2);
    added: vstack[`t; ([]seq: 3 4)];
    // added is 2; t contains seq: 1 2 3 4
    combined: vstack[t; ([]seq: 5)];
    // combined has 5 rows; t still has 4
    ```

### `compact`

Merge adjacent small chunks with `compact[table; target_rows]` (pepper) or
`compact(table, target_rows)` (chili). `target_rows` must be a positive integer.

A table symbol compacts a snapshot on the calling thread outside the variable
write lock, then publishes atomically while preserving concurrent `vstack`
appends. It returns the snapshot's row count, excluding appends received during
compaction. A dataframe value returns a compacted dataframe and leaves the
original unchanged. Existing snapshots remain valid in both cases.

Chunks already at least `target_rows` long keep their buffers. The target is a
grouping size, not a maximum: a merged group can exceed it, and the final group
can be smaller. Columns can have different chunk boundaries.

Only one compaction can be pending for the current table state. An explicit
call reports an error if a pass is already running; the automatic worker skips
busy tables and retries later. Replacements, drains, deletion, `upsert`, and
`upsertn` invalidate an in-flight pass. An explicit call then returns a
cancellation error instead of overwriting newer data; the worker discards its
cancelled result.

Assigning a slice back to the same variable, such as
`.s.buf: neg[.s.keep] # .s.buf`, also counts as a replacement. It clears the pending
queue entry, and a subsequent `vstack` schedules the table again. Frequent
replacements can repeatedly cancel compaction, leaving small chunks and slow
readers even when the retained row count is bounded. The worker cannot publish
its old prefix after a trim because that could restore removed rows. See the
[`upsertn` retention guidance](#upsertn) below.

### `xasc`

Sort a dataframe in ascending order.

| Parameters | Type | Description       |
| ---------- | ---- | ----------------- |
| columns    | list | Columns to sort   |
| df         | df   | DataFrame to sort |

### `xdesc`

Sort a dataframe in descending order.

| Parameters | Type | Description       |
| ---------- | ---- | ----------------- |
| columns    | list | Columns to sort   |
| df         | df   | DataFrame to sort |

### `xrename`

Rename columns of a dataframe.

| Parameters | Type | Description         |
| ---------- | ---- | ------------------- |
| columns    | list | Columns to rename   |
| df         | df   | DataFrame to rename |

### `xreorder`

Reorder columns of a dataframe.

| Parameters | Type | Description          |
| ---------- | ---- | -------------------- |
| columns    | list | Columns to reorder   |
| df         | df   | DataFrame to reorder |

### `upsert`

Append rows to a dataframe with `upsert[table; data]` (pepper) or `upsert(table, data)` (chili).

| Parameters | Type            | Description                                      |
| ---------- | --------------- | ------------------------------------------------ |
| table      | sym or dataframe | Table symbol or dataframe to append to          |
| data       | dataframe or list | Incoming dataframe or list of column values    |

A table symbol updates the dataframe in global state atomically and returns the
number of incoming rows. If the table does not exist, `data` must be a dataframe
and is used to create it. A dataframe value returns a new dataframe containing the
appended rows; the original dataframe is unchanged.

### `upsertn`

Append rows and retain at most the last `n` rows with `upsertn[table; data; n]`
(pepper) or `upsertn(table, data, n)` (chili). Rows are retained in append order;
no sorting or deduplication is performed.

| Parameters | Type              | Description                                      |
| ---------- | ----------------- | ------------------------------------------------ |
| table      | sym or dataframe  | Table symbol or dataframe to append to           |
| data       | dataframe or list | Incoming dataframe or list of column values      |
| n          | int               | Maximum number of rows to retain; must be non-negative |

- A table symbol updates global state. Appending and trimming are one atomic
  operation. The return value is the number of incoming rows, including rows
  discarded by the limit.
- A dataframe value returns a new dataframe and leaves the original unchanged.
- For table symbols, trimming happens before appending when the incoming batch
  has at least `n` rows or the stored table is already larger than `n`. Only rows
  that can survive are appended. Ordinary partial updates append in place and
  then trim, avoiding an extra copy of the stored table. Dataframe-value calls
  always trim a separate result before appending.
- Schema validation still applies, including when `n` is zero; a failed update
  leaves the stored table unchanged. Polars slices may share backing buffers, so
  the row limit is not a strict limit on resident memory.
- If the table does not exist, `data` must be a dataframe; the new table contains
  at most its last `n` rows.
- `n` equal to zero retains an empty dataframe with the same schema. Negative
  limits are rejected.
- When fewer than `n` rows are available, all available rows are retained.
  Unlike `-n#`, `upsertn` does not repeat rows to reach the limit.

For periodic retention on a `vstack` buffer, use an empty batch with the same
schema: ``upsertn[`.s.buf; 0 # data; .s.keep]``. This retains at most `.s.keep` rows
atomically without adding rows. It also invalidates pending compaction. Its
existing `extend` path merges fragmented numeric columns itself, which can copy
the retained data under the variable write lock. If called from `upd`, that work
runs on the apply thread. Choose the window and trim frequency against the
application's latency budget, especially while snapshots are alive; keep ordinary
incoming appends on `vstack` when using this pattern.

**Examples:**

=== "chili"

    ```chili
    t: ([]x: 1 2 3, price: 10.0 20.0 30.0);
    added: upsertn(`t, ([]x: 4 5, price: 40.0 50.0), 3);
    // added is 2; t contains x: 3 4 5

    bounded: upsertn(t, [6, 60.0], 2);
    // bounded contains x: 5 6; t still contains x: 3 4 5
    ```

=== "pepper"

    ```pepper
    t: ([]x: 1 2 3; price: 10.0 20.0 30.0);
    added: upsertn[`t; ([]x: 4 5; price: 40.0 50.0); 3];
    // added is 2; t contains x: 3 4 5

    bounded: upsertn[t; (6; 60.0); 2];
    // bounded contains x: 5 6; t still contains x: 3 4 5
    ```

### `insert`

Insert rows into a dataframe in global state. It will set the dataframe to the id if it doesn't exist. Also, it will keep the last row by key columns. This is a thread safe operation.

| Parameters | Type       | Description                        |
| ---------- | ---------- | ---------------------------------- |
| id         | str or sym | Id of the dataframe to insert into |
| by         | str or sym | Key columns                        |
| df         | dataframe  | dataframe to insert                |
