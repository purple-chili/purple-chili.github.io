# Command Line

## Command Line Shortcuts

- `\\` to exit
- `TAB` to complete
- `Alt+Enter` to insert a new line
- `Ctrl-R` to search history
- `Ctrl-C` to interrupt
- `Ctrl-D` to exit
- `Ctrl-A` to move to beginning of line
- `Ctrl-E` to move to end of line
- `Ctrl-U` to clear line
- `Ctrl-W` to kill to beginning of word

## Command Line Options

The `chili` or `pepper` binary supports the following command line arguments:

| Argument      | Short | Type           | Default | Description                                                             |
| ------------- | ----- | -------------- | ------- | ----------------------------------------------------------------------- |
| `src`         |       | String         | None    | Optional fixed source file path (positional argument)                   |
| `--port`      | `-p`  | Integer        | 0       | Port to listen on                                                       |
| `--remote`    | `-r`  | Boolean        | false   | Listen on all interfaces (0.0.0.0) instead of localhost (127.0.0.1)     |
| `--users`     | `-u`  | String (multi) |         | List of allowed usernames, separated by space                           |
| `--log-level` | `-l`  | String         | "info"  | Log level (e.g., info, debug, warn, error)                              |
| `--dir`       | `-d`  | String         | ""      | Directory for log files                                                 |
| `--interval`  | `-i`  | Integer        | 0       | Job execution interval in milliseconds                                  |
| `--kwargs`    | `-k`  | String         | ""      | String of code; the returned value will be set to the variable `kwargs` |

## Example Usage

=== "chili"

    ```sh
    chili script.chi --port 18000 --remote --users alice bob --log-level debug --dir /var/log/chili --interval 1000 --kwargs '{start_date: today(`)-7, end_date: today(`)}'
    ```

=== "pepper"

    ```sh
    pepper script.pep --port 18000 --remote --users alice bob --log-level debug --dir /var/log/chili --interval 1000 --kwargs '{start_date: today[`]-7; end_date: today`}'
    ```
