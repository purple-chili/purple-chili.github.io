# Data Types

This document describes the core data types used in the `Chili`.

## Atomic Types

| Type        | Description                                               | Literal                                                     |
| ----------- | --------------------------------------------------------- | ----------------------------------------------------------- |
| `bool`      | Boolean value (`true`/`false`)                            | `ob` or `1b`                                                |
| `u8`        | 8-bit unsigned integer                                    | `0x00` , `0x12`                                             |
| `i16`       | 16-bit signed integer                                     | `0h` , `18h`, `42i16`                                       |
| `i32`       | 32-bit signed integer                                     | `0i` , `18i`, `42i32`                                       |
| `i64`       | 64-bit signed integer                                     | `0` , `18`                                                  |
| `date`      | Date, days since 1970-01-01                               | `2025.07.22` , `2025.08.18`                                 |
| `time`      | Time of day, nanoseconds since midnight                   | `00:00:00.000` , `12:34:56.123456789`                       |
| `datetime`  | Milliseconds since 1970-01-01T00:00:00.000                | `2025.07.22T00:00:00.000` , `2025.08.18T00:00:00.123`       |
| `timestamp` | Nanoseconds since 1970-01-01T00:00:00.000                 | `2025.07.22D00:00:00.000` , `2025.08.18D00:00:00.123456789` |
| `duration`  | Duration in nanoseconds                                   | `0D00:00:00` , `123D12:34:56.123456789`                     |
| `f32`       | 32-bit floating point                                     | `0.0e` , `-1.23e`, `3E3e` , `1f32`                          |
| `f64`       | 64-bit floating point                                     | `0.0` , `-1.23`, `3E3`                                      |
| `str`       | String                                                    | `""` , `"string"`                                           |
| `sym`       | Symbol (interned string, often used for categorical data) | `` ` `` , `` `symbol ``                                     |
| `expr`      | Expression (internal use)                                 | `col("column")` , `lit(0b)`                                 |
| `null`      | Null value                                                | `0n`                                                        |

!!! note

    - `time` data type only ranges from 00:00:00.000000000 to 23:59:59.999999999
    - `timestamp` stores as nanoseconds since Unix epoch (1970-01-01T00:00:00Z)
    - `date` stores as days since Unix epoch (1970-01-01)

## Collection Types

| Type        | Description                                                          |
| ----------- | -------------------------------------------------------------------- |
| `series`    | Homogeneous array (Polars Series), type code depends on element type |
| `matrix`    | 2D array of f64 values                                               |
| `list`      | Mixed list (heterogeneous collection of values)                      |
| `dict`      | Dictionary (string keys to values)                                   |
| `dataframe` | DataFrame (table, Polars DataFrame)                                  |

Some examples for `series` type:

```chili
1 2 3u64
1 0n 3i128
0w 0n 3E3f32
1.0 2.0 -0wf64
1.0 2.0 3.0e
1.0 2.0 3.0f
```

## Special Types

| Type            | Description                          |
| --------------- | ------------------------------------ |
| `fn`            | Function (internal representation)   |
| `err`           | Error (string message)               |
| `delayed arg`   | Delayed argument (internal use)      |
| `par dataframe` | Partitioned DataFrame (internal use) |

## Type Name Conventions

- Plural types (e.g., `bools`, `i32s`, `strs`, `syms`) refer to `Series` of the corresponding atomic type.
- `matrix` is a 2D array of f64.
- `list` is a mixed-type list (can contain any `chili` values).
- `dict` is a mapping from string keys to `chili` values.
- `dataframe` is a DataFrame (table).

use `type` function to get the type name of a `chili` value.

## Nulls

- `0n` is the null value.
- Series can also contain nulls.

## Temporal Types

- `date`: days since 1970-01-01
- `time`: nanoseconds since midnight
- `datetime`: milliseconds since 1970-01-01T00:00:00.000
- `timestamp`: nanoseconds since 1970-01-01T00:00:00.000
- `duration`: nanoseconds

## Symbol and String

- `sym`: interned string, used for categorical data
- `str`: regular string

usually `sym` is the same as `str`, but in series and dataframe, `sym` is categorical data type.

## Casting

Available types for casting:

.e.g `` `i64$1.5 ``

| Type             | Description            |
| ---------------- | ---------------------- |
| bool             | Boolean                |
| u8               | UInt8                  |
| u16              | UInt16                 |
| u32              | UInt32                 |
| u64              | UInt64                 |
| i8               | Int8                   |
| i16              | Int16                  |
| i32              | Int32                  |
| i64              | Int64                  |
| i128             | Int128                 |
| f32              | Float32                |
| f64              | Float64                |
| date             | Date                   |
| timestamp        | Datetime(Nanoseconds)  |
| datetime         | Datetime(Milliseconds) |
| time             | Time                   |
| duration         | Duration(Nanoseconds)  |
| sym, same as cat | Categorical            |
| str              | String                 |

Available temporal types, only for casting temporal data types in query:

.e.g `` select `year$date from df``

| Type        | Description |
| ----------- | ----------- |
| year        | Year        |
| quarter     | Quarter     |
| month       | Month       |
| month_start | Month start |
| month_end   | Month end   |
| weekday     | Weekday     |
| day         | Day         |
| hour        | Hour        |
| minute      | Minute      |
| second      | Second      |
| ms          | MS          |
| ns          | NS          |
