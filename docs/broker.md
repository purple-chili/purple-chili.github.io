# Broker

## Functions

### `.broker.publish`

Publish data for table. This only serialize the data once and publish to all subscribers.

| Parameters | Type      | Description     |
| ---------- | --------- | --------------- |
| table      | sym       | Table name      |
| data       | dataframe | Data to publish |

### `.broker.subscribe`

Subscribe to a table for handle.

| Parameters | Type | Description            |
| ---------- | ---- | ---------------------- |
| handle     | i64  | Handle to subscribe to |
| tables     | syms | Tables to subscribe to |

### `.broker.unsubscribe`

Unsubscribe from a table for handle.

| Parameters | Type | Description                |
| ---------- | ---- | -------------------------- |
| handle     | i64  | Handle to unsubscribe from |
| tables     | syms | Tables to unsubscribe from |

### `.broker.validateSeq`

Fix a corrupted sequence file by removing last invalid message, return the number of valid messages in the file.

| Parameters | Type | Description |
| ---------- | ---- | ----------- |
| file       | str  | File to fix |
