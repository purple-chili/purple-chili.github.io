# Broker

## Functions

### `.broker.publish`

Publish data for table. This only serialize the data once and publish to all subscribers.

| Parameters | Type | Description                             |
| ---------- | ---- | --------------------------------------- |
| upd_name   | sym  | Update name                             |
| table      | sym  | Table name                              |
| message    | any  | Message to publish, usually a dataframe |

### `.broker.subscribe`

Subscribe to a table for handle.

| Parameters | Type | Description                                           |
| ---------- | ---- | ----------------------------------------------------- |
| handle     | i64  | Handle to subscribe to                                |
| topics     | syms | Topics to subscribe to, usually a list of table names |

### `.broker.subscribeFiltered`

Register a subscriber on one topic with an optional per-handle row filter. Empty `values` means no filter (same as unfiltered subscribe for that topic).

| Parameters | Type       | Description                                      |
| ---------- | ---------- | ------------------------------------------------ |
| handle     | i64        | Handle to subscribe                              |
| topic      | sym        | Topic (table) name                               |
| column     | sym or str | Column to filter on                              |
| values     | syms/strs  | Allowed values; empty list disables the filter   |

### `.broker.unsubscribe`

Unsubscribe from a table for handle.

| Parameters | Type | Description                                               |
| ---------- | ---- | --------------------------------------------------------- |
| handle     | i64  | Handle to unsubscribe from                                |
| topics     | syms | Topics to unsubscribe from, usually a list of table names |

### `.broker.validateSeq`

Fix a corrupted sequence file by removing the last invalid message, and return the number of valid messages in the file.

Accepts whole-file gzip sequence logs (`.seq.gz` or gzip magic) without gunzip-to-temp.

| Parameters       | Type | Description                          |
| ---------------- | ---- | ------------------------------------ |
| file             | str  | File to fix, usually a sequence file |
| must_deserialize | bool | Whether to deserialize each message  |

### `.broker.validateSeqStrict`

Strict variant of `validateSeq`. Returns an error on any corrupt or truncated frame instead of silently truncating. Opens the file read-only. Also accepts whole-file gzip sequence logs.

| Parameters       | Type | Description                          |
| ---------------- | ---- | ------------------------------------ |
| file             | str  | File to validate                     |
| must_deserialize | bool | Whether to deserialize each message  |

### `.broker.eod`

Publish an EOD message to all subscribers.

| Parameters | Type | Description        |
| ---------- | ---- | ------------------ |
| message    | any  | Message to publish |

### `.broker.list`

List all topics with subscriber handles.

| Parameters | Type | Description |
| ---------- | ---- | ----------- |
| None       | None | None        |

## Other Functions

### `replay`

Replay a sequence file. Accepts whole-file gzip (`.seq.gz` or gzip magic); skip uses read-and-discard so non-seekable streams work. Tolerates torn trailing records — stops at the last valid frame with a warning.

| Parameters  | Type            | Description                      |
| ----------- | --------------- | -------------------------------- |
| file        | str             | File to replay                   |
| start       | timestamp or i64| Start time or start index        |
| end         | i64             | End index                        |
| table_names | syms            | Table names to replay            |
| eval        | bool            | Whether to evaluate the messages |
| handle      | i64             | Handle number                    |

### `tick`

Fetch-and-add on an internal counter: add `inc` under a process-wide write lock, then return the **new** (post-increment) value. Counters are independent per `index` (`0..1023`). Safe under concurrent inbound IPC connections — concurrent `tick` calls on the same index do not lose updates.

Supported contract (may be depended on):

- Return value is always the value **after** applying `inc`.
- Atomic across concurrent connections / eval threads.
- Negative `inc` is allowed (used for release / reset patterns).

Use `tick[index; 0]` / `tick(index, 0)` to read the current value without changing it. Indices are not reserved for the tickerplant: `tick[0; …]` is conventionally the message counter, but other slots may be used as application counters (for example a gateway admission gate).

| Parameters | Type | Description                            |
| ---------- | ---- | -------------------------------------- |
| index      | i64  | Tick counter index (0..1023)           |
| inc        | i64  | Increment value (may be negative)      |

### `tock`

Set a tick counter to an absolute value (not an increment). Prefer this when reseeding after `validateSeq` instead of the two-step `tick[0; neg tick[0; 0]]; tick[0; n]` pattern.

| Parameters | Type | Description                  |
| ---------- | ---- | ---------------------------- |
| index      | i64  | Tick counter index (0..1023) |
| value      | i64  | Absolute counter value       |

### `lpt`

Atomic tickerplant update under one lock: write ``(`upd; table; data)`` to `.tick.msgHandle`, `.broker.publish`, then advance a tick counter. Stock `.tick.upd` is `lpt[table; data; 0]`.

Third argument:

- **int** `tick_index` — log and publish `data` as given, then `tick[tick_index; 1]`.
- **sym/str** `stamp_col` — under the same lock, stamp that column with `tick[0; 0] + i` (`u64`) per row, log/publish the stamped frame, then `tick[0; count data]`.

Requires `.tick.msgHandle` to be set. Returns the new counter value at the tick slot used.

| Parameters       | Type           | Description                                      |
| ---------------- | -------------- | ------------------------------------------------ |
| table            | sym or str     | Table name                                       |
| data             | any            | Payload (dataframe required when stamping)       |
| tick_index_or_col| i64 or sym/str | Counter index, or column name to stamp with seq  |
