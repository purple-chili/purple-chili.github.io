# Config

Configure dataframe display and automatic compaction.

## Functions

### `console`

Control how many rows and columns of a dataframe are printed to the console.

| Parameters | Type | Description      |
| ---------- | ---- | ---------------- |
| rows       | list | Rows to print    |
| cols       | list | Columns to print |

### `.compact.configure`

Configure automatic compaction of symbol-form `vstack` buffers. Call
`.compact.configure[interval_ms; target_rows]` (pepper) or
`.compact.configure(interval_ms, target_rows)` (chili). Returns null.

- `interval_ms` is a non-negative integer: milliseconds between worker passes,
  default 250. Zero disables future passes; an in-flight pass may finish.
- `target_rows` is a positive integer: the grouping target for merging small
  chunks, default 65,536. Already-large chunks retain their buffers.

Configuration applies to the engine. The worker starts on the first nonempty
symbol-form `vstack` append and is independent of the job scheduler. Re-enabling
it also schedules tables with pending append work. `shutdown()` stops the worker
and waits for its running pass; configuration after shutdown is rejected.

Python exposes `engine.set_auto_compaction(interval_ms=250, target_rows=65536)`
and constructor options `ChiliEngine(compaction_interval=250,
compaction_target_rows=65536)`.

Compaction does not implement retention or a hard latency guarantee. See
[`compact`](df.md#compact) for snapshot behavior and the interaction with frequent
table-replacing trims, and [`upsertn`](df.md#upsertn) for bounded retention.
