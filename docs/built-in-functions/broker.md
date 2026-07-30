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

Increment the internal tick count and return the new value. Use `tick[index; 0]` / `tick(index, 0)` to read the current value without changing it.

| Parameters | Type | Description                            |
| ---------- | ---- | -------------------------------------- |
| index      | i64  | Tick counter index (0..1024)           |
| inc        | i64  | Increment value                        |

### `tock`

Set a tick counter to an absolute value (not an increment). Prefer this when reseeding after `validateSeq` instead of the two-step `tick[0; neg tick[0; 0]]; tick[0; n]` pattern.

| Parameters | Type | Description                  |
| ---------- | ---- | ---------------------------- |
| index      | i64  | Tick counter index (0..1024) |
| value      | i64  | Absolute counter value       |
