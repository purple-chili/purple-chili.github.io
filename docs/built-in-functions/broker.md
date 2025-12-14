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

### `.broker.unsubscribe`

Unsubscribe from a table for handle.

| Parameters | Type | Description                                               |
| ---------- | ---- | --------------------------------------------------------- |
| handle     | i64  | Handle to unsubscribe from                                |
| topics     | syms | Topics to unsubscribe from, usually a list of table names |

### `.broker.validateSeq`

Fix a corrupted sequence file by removing last invalid message, return the number of valid messages in the file.

| Parameters       | Type | Description                          |
| ---------------- | ---- | ------------------------------------ |
| file             | str  | File to fix, usually a sequence file |
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

Replay a sequence file.

| Parameters  | Type | Description                      |
| ----------- | ---- | -------------------------------- |
| file        | str  | File to replay                   |
| start       | i64  | Start time                       |
| end         | i64  | End time                         |
| table_names | syms | Table names to replay            |
| eval        | bool | Whether to evaluate the messages |

### `tick`

Update the internal tick count.

| Parameters | Type | Description |
| ---------- | ---- | ----------- |
| n          | i64  | Tick count  |
