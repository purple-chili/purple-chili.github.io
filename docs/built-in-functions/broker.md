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

Subscribe a handle to topics and return the **replay bound**: the value of `tick[0; 0]` at the moment the handle was registered.

| Parameters | Type | Description                                                                          |
| ---------- | ---- | ------------------------------------------------------------------------------------ |
| handle     | i64  | Handle to subscribe                                                                  |
| topics     | syms | Topics to subscribe to, usually a list of table names (sym, str, or a list of either) |

Registration and reading the counter share the `lpt` lock. The counter is a
message bound only when `lpt` counts messages in slot 0 from the start of this
log. With row stamping, a seeded counter, or another tick slot, do not pass it
to `replay`. Use `.broker.subscribeLog` for an explicit message bound.

When called for a handle other than the calling connection (from the REPL, a job, another connection), the subscription goes live immediately.

### `.broker.subscribeFiltered`

Register a subscriber on one topic with an optional per-handle row filter, and return the replay bound exactly as `.broker.subscribe` does. Empty `values` means no filter (same as unfiltered subscribe for that topic).

| Parameters | Type       | Description                                      |
| ---------- | ---------- | ------------------------------------------------ |
| handle     | i64        | Handle to subscribe                              |
| topic      | sym        | Topic (table) name                               |
| column     | sym or str | Column to filter on                              |
| values     | syms/strs  | Allowed values; empty list disables the filter   |

### `.broker.subscribeLog` and `.broker.subscribeFilteredLog`

Available in 0.11.4. The unfiltered form takes `(handle; topics; log)`; the
filtered form takes `(handle; topic; column; values; log)`. `log` is the
sequence-file handle used by `lpt`.

They return `(counter; message_end; log_path)`. Registration, the slot-0
application counter, and the actual log path and exclusive message end are
captured under the `lpt` lock. The message count is independent of row counts,
sequence seeds, and mutable tick slots. Each complete log append counts once,
including an empty dataframe. Reopen and rotation initialize it from the log.
No log scan is needed during subscription.

The bundled tickerplant returns `(log_path; counter; schema; message_end)`.
The bundled subscriber uses the fourth field for replay. Upgrade tickerplant
and subscriber together; new subscribers reject replies without a message
bound. Old subscribers still read the legacy counter and remain unsafe with
row-stamping tickerplants. Existing affected subscriber state must be rebuilt
from retained logs: correcting future bounds cannot repair old duplicates or
skipped frames. Custom tickerplants must adopt the extended reply too.

### `.broker.unsubscribe`

Unsubscribe from a table for handle.

| Parameters | Type | Description                                               |
| ---------- | ---- | --------------------------------------------------------- |
| handle     | i64  | Handle to unsubscribe from                                |
| topics     | syms | Topics to unsubscribe from, usually a list of table names |

### `.broker.validateSeq`

Fix a corrupted sequence file by removing a torn trailing message, and return the number of valid messages in the file.

Only a structurally incomplete tail is removed: a short header, a short payload, or a length larger than the rest of the file. With `must_deserialize`, a complete message that cannot be decoded is reported in the log and kept, along with everything after it (`replay` skips such a message and applies the rest).

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

## Slow subscribers

Every subscriber gets its own outbound queue and writer thread, so `.broker.publish` and `lpt` never wait on a slow or stalled consumer. A backlog costs the publisher memory, not time.

By default the queue has no bound. Bounds are a policy checked after each publish, set from the embedding API (`ChiliEngine` in Python):

| Setting                            | Default | Meaning                                                                                   |
| ---------------------------------- | ------- | ----------------------------------------------------------------------------------------- |
| `set_subscriber_queue_max(n)`      | `0`     | `0`: no frame bound. `n > 0`: shed above `n` queued frames. `n < 0`: legacy blocking write |
| `set_subscriber_queue_max_bytes(n)` | `0`     | Shed above `n` queued bytes (`0` = no byte bound)                                          |
| `set_subscriber_queue_grace_ms(ms)` | `0`     | Shed only once the queue has stayed over a bound this long (`0` = at the first breach)     |

A shed subscriber is disconnected; its `.handle.onDisconnected` callback can reconnect and recover. `stats()` reports `queue_depth_by_handle` and `queue_bytes_by_handle` so a backlog can be watched before it matters.

Subscriptions of a disconnected, closed or shed handle are removed from `.broker.list` automatically.

## Other Functions

### `replay`

Replay a sequence file. Accepts whole-file gzip (`.seq.gz` or gzip magic); skip uses read-and-discard so non-seekable streams work. Tolerates torn trailing records — stops at the last valid frame with a warning.

| Parameters  | Type            | Description                      |
| ----------- | --------------- | -------------------------------- |
| file        | str             | File to replay                   |
| start       | timestamp or i64| Start time or start index        |
| end         | i64             | Exclusive message index          |
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

Atomic tickerplant update under one lock: write ``(`upd; table; data)`` to
`handle`, `.broker.publish`, then advance a tick counter. Stock `.tick.upd` is
`lpt[table; data; 0; .tick.msgHandle]`.

Third argument:

- **int** `tick_index` — log and publish `data` as given, then `tick[tick_index; 1]`.
- **sym/str** `stamp_col` — under the same lock, stamp that column with `tick[0; 0] + i` (`u64`) per row, log/publish the stamped frame, then `tick[0; count data]`.

Fourth argument `handle` is the log-file handle, bound inside the lock (pass
`.tick.msgHandle` or any other sequence handle, e.g. a per-table tplog).

Returns the new counter value at the tick slot used.

| Parameters        | Type           | Description                                     |
| ----------------- | -------------- | ----------------------------------------------- |
| table             | sym or str     | Table name                                      |
| data              | any            | Payload (dataframe required when stamping)      |
| tick_index_or_col | i64 or sym/str | Counter index, or column name to stamp with seq |
| handle            | i64            | Log/sequence handle                            |

