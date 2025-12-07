# User Guide

`chili` provides two binaries:

- `chili` uses a modern syntax with query language similar to `javascript`.
- `pepper` uses a vintage syntax with query language similar to `q`.

The data analytics and engineering engine is powered by [polars](https://pola.rs/).

## Installation

=== "chili"

    Download the latest binary file from GitHub.

    ```sh
    curl -L -H "Accept: application/vnd.github+json" \
      https://api.github.com/repos/purple-chili/chili/releases/latest \
      | grep browser_download_url \
      | cut -d'"' -f 4 \
      | grep chili_ \
      | xargs curl -OL
    ```

    Then extract the binary file to $PATH, e.g. `~/bin~`

    ```sh
    tar -xvf chili*.tar.gz -C ~/bin/
    ```

=== "pepper"

    Download the latest binary file from GitHub.

    ```sh
    curl -L -H "Accept: application/vnd.github+json" \
      https://api.github.com/repos/purple-chili/chili/releases/latest \
      | grep browser_download_url \
      | cut -d'"' -f 4 \
      | grep pepper_ \
      | xargs curl -OL
    ```

    Then extract the binary file to $PATH, e.g. `~/bin~`

    ```sh
    tar -xvf pepper*.tar.gz -C ~/bin/
    ```

## Getting Started

- [Command Line]
- [Syntax]
- [Data Types]
- [Operators]
- [Temporal Functions]
- [OS Functions]
- [Job Scheduler Functions]
- [IO Functions]
- [Message Broker Functions]
- [IPC]
- [Partitioned DataFrame]
- [Query]
- [Environment Variables]
- [Data Flow]

## Cookbook

- [Real-time case]

<!-- ## Getting Started

## Topics

- [Architecture](doc/architecture.md) - System architecture and design overview
- [Command Line Arguments](doc/args.md) - Command line arguments for `chili`
- [Editor](doc/editor.md) - Editor integration and features
- [IO](doc/io.md) - Input and output functions
- [IPC (Inter-Process Communication)](doc/ipc.md) - Communication protocols and interfaces
- [Job Scheduler](doc/job.md) - Job scheduler for `chili`
- [Operating System Functions](doc/os.md) - Operating system functions
- [Operators](doc/op.md) - Operators in `chili`
- [Partitioned DataFrame](doc/partitioned-df.md) - Partitioning data in `chili`
- [Query](doc/query.md) - Query syntax for data manipulation
- [Temporal Data](doc/temporal.md) - Working with temporal data in `chili` -->

<!-- ## [Change Log](doc/changelog.md) -->

## To Do

refer to [To Do] for future features.

## Change Log

refer to [Change Log] for the latest updates.

[Command Line]: cmd-line.md
[Syntax]: syntax.md
[Data Types]: data-types.md
[Operators]: op.md
[OS Functions]: os.md
[Temporal Functions]: temporal.md
[Job Scheduler Functions]: job.md
[IO Functions]: io.md
[Message Broker Functions]: broker.md
[IPC]: ipc.md
[Partitioned DataFrame]: partitioned-df.md
[Data Flow]: data-flow.md
[Query]: query.md
[Environment Variables]: env.md
[Real-time case]: real-time-case.md
[To Do]: todo.md
[Change Log]: changelog.md
