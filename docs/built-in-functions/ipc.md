# IPC

## Overview

IPC (Inter-Process Communication) in chili enables communication between processes, supporting both local and remote connections. It provides flexible authentication, adaptive compression based on network bandwidth, and compatibility with q and chili protocols.

As chili is supporting most q IPC protocol, most q interfacing packages can be used directly with chili.

## Environment Variables

- `CHILI_IPC_TOKEN`: If no password is provided, the connection uses this environment variable as the password (if set).
- `CHILI_NETWORK_BANDWIDTH`: Sets the network bandwidth in MB/s. If not set, defaults to 1000MB/s. The bandwidth value determines the IPC compression method.

## Compression

!!! tip

    The compression method is chosen based on the network bandwidth:

    - **> 2500MB/s**: No compression
    - **>= 1000MB/s**: LZ4 (better than ZSTD at this range)
    - **< 1000MB/s**: ZSTD (better than LZ4 at this range)

    Compression Ratios:

    - LZ4: ~62%
    - ZSTD: ~45%

## Connection Formats

- `q://` — Compatible with kdb+
- `chili://` — Only for `chili` and `pepper`

## Handle Types

- `Incoming`: Incoming connection from another process, used for receiving data,
- `Outgoing`: Outgoing connection to another process, used for sending data,
- `Publishing`: Publishing connection, used for asynchronously publishing data to a topic, (usually reusing an incoming connection)
- `Subscribing`: Subscribing connection, used for asynchronously subscribing to a topic, (usually reusing an outgoing connection)
- `Disconnected`: Indicates that the connection is disconnected
- `File`: File handle, used for writing strings to a file
- `Sequence`: Sequence file handle, used for writing mixed list to a sequence file
- `New`: an empty file handle, can be changed to `File` or `Sequence` when writing the first message(string for `File`, mixed list for `Sequence`)

## Functions

### `.handle.list`

No parameters, returns a dataframe of all current handles with the following columns:

- `num`: Handle number
- `socket`: Socket address
- `conn_type`: Connection type
- `ipc_type`: IPC type
- `is_local`: Whether the connection is local
- `on_disconnected`: Callback function for disconnected event

| Parameters | Type | Description |
| ---------- | ---- | ----------- |
| None       | None | None        |

### `.handle.open`

Opens a handle to the specified socket and returns the handle number(i64).

| Parameters | Type       | Description    |
| ---------- | ---------- | -------------- |
| socket     | str or sym | Socket address |

=== "chili"

    ```chili
    handle:.handle.open(`q://:18000);
    handle:.handle.open(`chili://:18000);
    ```

=== "pepper"

    ```pepper
    .handle.open `q://:18000;
    .handle.open `chili://:18000;
    ```

### `.handle.close`

Closes the specified handle.

| Parameters | Type | Description   |
| ---------- | ---- | ------------- |
| handle     | i64  | Handle number |

### `.handle.connect`

Connects an existing handle, mainly for reconnecting a handle.

| Parameters | Type | Description   |
| ---------- | ---- | ------------- |
| handle     | i64  | Handle number |

### `.handle.onDisconnected`

Sets a callback function for the specified handle.

| Parameters | Type | Description       |
| ---------- | ---- | ----------------- |
| handle     | i64  | Handle number     |
| callback   | str  | Callback function |

## Code Snippet

=== "chili"

    ```chili
    // List all handles
    handles: .handle.list();

    // Open and connect a handle
    h: .handle.open (`chili://:18000);

    // Set a callback
    .handle.onDisconnected(h; my_callback);

    // Close a handle
    .handle.close(h);
    ```

=== "pepper"

    ```pepper
    // List all handles
    handles: .handle.list[]

    // Open and connect a handle
    h: .handle.open `chili://:18000

    // Set a callback
    .handle.onDisconnected[h; my_callback]

    // Close a handle
    .handle.close h
    ```
