# DataFrame

## Functions

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

Vertically stack two dataframes.

| Parameters | Type | Description      |
| ---------- | ---- | ---------------- |
| df1        | df   | First dataframe  |
| df2        | df   | Second dataframe |

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
- If the table does not exist, `data` must be a dataframe; the new table contains
  at most its last `n` rows.
- `n` equal to zero retains an empty dataframe with the same schema. Negative
  limits are rejected.
- When fewer than `n` rows are available, all available rows are retained.
  Unlike `-n#`, `upsertn` does not repeat rows to reach the limit.

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
