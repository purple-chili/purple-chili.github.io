# IPC

## Overview

IPC (Inter-Process Communication) in chili enables communication between processes, supporting both local and remote connections. It provides flexible authentication, adaptive compression based on network bandwidth, and compatibility with q and chili protocols.

As chili is supporting most q IPC protocol, most q interfacing packages can be used directly with chili.

## Environment Variables

- `CHILI_IPC_TOKEN`: On a client, if no password is provided, the connection uses this environment variable as the password (if set). On a listening process, when this variable is set every client must present the same value as its password, otherwise the connection is refused. When it is not set, only the username is checked (`--users`).
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

A sequence file (`file://`) is locked exclusively while it is open: opening a log that this or another process is already writing is an error, because a second writer would truncate at the last complete message and then overwrite the first writer's data.

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

### `.handle.exists`

Checks if a handle exists.

| Parameters | Type | Description   |
| ---------- | ---- | ------------- |
| handle     | i64  | Handle number |

=== "chili"

    ```chili
    .handle.exists(handle);
    ```

=== "pepper"

    ```pepper
    .handle.exists[handle];
    ```

### `.handle.close`

Closes the specified handle. For a connection this shuts the socket down, so the peer is disconnected and any reader thread on it stops. Subscriptions of the handle are removed.

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

### `.handle.rotate`

Swap a file handle's writer to a new `file://` path. Flushes the old writer first. Skips rotation when the target URI already exists in the handle map. For sequence files, accepts non-empty files and sets the handle tick count to the existing message count.

| Parameters | Type       | Description              |
| ---------- | ---------- | ------------------------ |
| handle     | i64        | Handle number            |
| uri        | str or sym | New `file://` path       |

### `.handle.rotateTick`

Same as `.handle.rotate`, and additionally sets the tick counter `tick_index` to the new file's message count in the same locked step. A tickerplant keeps its replay bound in `tick[0]`; resetting it in a separate statement leaves a window in which a concurrent `lpt` is counted against the old value. Rotating to the file that is already open changes nothing, counters included.

| Parameters | Type       | Description                                     |
| ---------- | ---------- | ----------------------------------------------- |
| handle     | i64        | Handle number                                   |
| uri        | str or sym | New `file://` path                              |
| tick_index | i64        | Tick counter to set to the new file's message count |

### `.handle.subscribing`

Start reading an outgoing handle: every message the peer publishes is evaluated as it arrives. The handle must be an outgoing connection; any other handle is left untouched and an error is returned.

| Parameters | Type | Description   |
| ---------- | ---- | ------------- |
| handle     | i64  | Handle number |

### `.handle.holding`

Start reading an outgoing handle in **hold mode**: published messages are read off the socket and parked in this process, not evaluated. Call it right after the subscribe request and before `replay`, then call `.handle.release`. The backlog that builds up during a slow replay then sits in the subscriber instead of the publisher's outbound queue.

| Parameters | Type | Description   |
| ---------- | ---- | ------------- |
| handle     | i64  | Handle number |

### `.handle.release`

Apply the messages parked by `.handle.holding` in arrival order, then switch the handle to live evaluation. Returns the number of messages applied. No live message can be evaluated ahead of a parked one.

| Parameters | Type | Description   |
| ---------- | ---- | ------------- |
| handle     | i64  | Handle number |

=== "chili"

    ```chili
    info: h([`.tick.subscribe, []]);
    .handle.holding(h);
    replay(info(0), 0, info(1), [], 1b, h);
    .handle.release(h);
    ```

=== "pepper"

    ```pepper
    info: h (`.tick.subscribe; ());
    .handle.holding[h];
    replay[info[0]; 0; info[1]; (); 1b; h];
    .handle.release[h];
    ```

### `.handle.fsync`

Flush a file handle's buffered data to disk (`fdatasync`), for on-demand durability control.

| Parameters | Type | Description   |
| ---------- | ---- | ------------- |
| handle     | i64  | Handle number |

### `.handle.reply`

Fire-and-forget async write to any connected handle, including incoming caller connections (`this.h`).

| Parameters | Type | Description   |
| ---------- | ---- | ------------- |
| handle     | i64  | Handle number |
| msg        | any  | Message       |

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
