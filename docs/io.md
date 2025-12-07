# I/O Operations

## Data Type Mapping

The I/O functions support automatic data type conversion using the following mapping:

| Type        | Polars DataType        |
| ----------- | ---------------------- |
| `bool`      | Boolean                |
| `u8`        | UInt8                  |
| `u16`       | UInt16                 |
| `u32`       | UInt32                 |
| `u64`       | UInt64                 |
| `i8`        | Int8                   |
| `i16`       | Int16                  |
| `i32`       | Int32                  |
| `i64`       | Int64                  |
| `i128`      | Int128                 |
| `f32`       | Float32                |
| `f64`       | Float64                |
| `date`      | Date                   |
| `timestamp` | Datetime(Nanoseconds)  |
| `datetime`  | Datetime(Milliseconds) |
| `time`      | Time                   |
| `duration`  | Duration(Nanoseconds)  |
| `sym`       | Categorical            |
| `cat`       | Categorical            |
| `str`       | String                 |

## File Reading Functions

### `rcsv`

Reads a CSV file and returns a DataFrame.

| Parameters    | Type       | Description                                          |
| ------------- | ---------- | ---------------------------------------------------- |
| path          | str or sym | File path to the CSV file                            |
| has_header    | bool       | Whether the CSV has a header row                     |
| separator     | str        | Single character separator (e.g., "," for comma)     |
| ignore_errors | bool       | Whether to ignore parsing errors                     |
| dtypes        | dict       | schema dictionary mapping column names to data types |

**Example:**

=== "chili"

    ```chili
    // Read CSV with custom schema
    dtypes: {col1:`i64, col2:`str, col3:`f64};
    df = rcsv("data.csv", 1b, ",", 1b, dtypes);
    // or read all columns
    df = rcsv("data.csv", 1b, ",", 1b, {});
    ```

=== "pepper"

    ```pepper
    // Read CSV with custom schema
    dtypes: {col1:`i64; col2:`str; col3:`f64};
    df = rcsv["data.csv"; 1b; ","; 1b; dtypes];
    // or read all columns
    df = rcsv["data.csv"; 1b; ","; 1b; {}];
    ```

### `rjson`

Reads a JSON file and returns a DataFrame.

| Parameters | Type       | Description                                          |
| ---------- | ---------- | ---------------------------------------------------- |
| path       | str or sym | File path to the JSON file                           |
| dtypes     | dict       | schema dictionary mapping column names to data types |

**Example:**

=== "chili"

    ```chili
    // Read JSON with custom schema
    dtypes: {id:`i64, name:`str, value:`f64};
    df = rjson("data.json", dtypes);
    // Read JSON with no schema
    df = rjson("data.json", {});
    ```

=== "pepper"

    ```pepper
    // Read JSON with custom schema
    dtypes: {id:`i64; name:`str; value:`f64};
    df = rjson["data.json"; dtypes];
    // Read JSON with no schema
    df = rjson["data.json"; {}];
    ```

### `rparquet`

Reads a Parquet file and returns a DataFrame.

| Parameters | Type       | Description                                    |
| ---------- | ---------- | ---------------------------------------------- |
| path       | str or sym | File path to the Parquet file                  |
| n_rows     | i64        | Number of rows to read (0 for all rows)        |
| rechunk    | bool       | Whether to rechunk the data                    |
| columns    | syms       | Column names to select (empty for all columns) |

**Example:**

=== "chili"

    ```chili
    // Read specific columns from Parquet file
    df = rparquet("data.parquet", 1000, 1b, `col1`col2`col3);
    ```

=== "pepper"

    ```pepper
    // Read specific columns from Parquet file
    df = rparquet["data.parquet"; 1000; 1b; `col1`col2`col3];
    ```

### `rtxt`

Reads a text file and returns its contents as a string.

| Parameters | Type       | Description                |
| ---------- | ---------- | -------------------------- |
| path       | str or sym | File path to the text file |

## File Writing Functions

### `wcsv`

Writes a DataFrame to a CSV file.

| Parameters | Type       | Description                                                    |
| ---------- | ---------- | -------------------------------------------------------------- |
| path       | str or sym | File path to the CSV file                                      |
| df         | dataframe  | DataFrame to write                                             |
| separator  | str        | Single character separator (e.g., "," for comma)               |
| append     | bool       | Whether to append to existing file (true) or overwrite (false) |

**Example:**

=== "chili"

    ```chili
    wcsv("output.csv", df, ",");
    ```

=== "pepper"

    ```pepper
    wcsv["output.csv"; df; ","]
    ```

### `wjson`

Writes a DataFrame to a JSON file in JSON Lines format.

| Parameters | Type       | Description                |
| ---------- | ---------- | -------------------------- |
| path       | str or sym | File path to the JSON file |
| df         | dataframe  | DataFrame to write         |

**Example:**

=== "chili"

    ```chili
    wjson("output.json", df);
    ```

=== "pepper"

    ```pepper
      wjson["output.json"; df]
    ```

### `wparquet`

Writes a DataFrame to a Parquet file.

| Parameters        | Type       | Description                   |
| ----------------- | ---------- | ----------------------------- |
| path              | str or sym | File path to the Parquet file |
| df                | dataframe  | DataFrame to write            |
| compression_level | int        | Compression level (1-22)      |

**Example:**

=== "chili"

    ```chili
    size = wparquet("output.parquet", df, 6);
    ```

=== "pepper"

    ```pepper
    size = wparquet["output.parquet"; df; 6]
    ```

### `wtxt`

Writes text content to a file.

| Parameters | Type       | Description                                                    |
| ---------- | ---------- | -------------------------------------------------------------- |
| path       | str or sym | File path to the text file                                     |
| content    | str        | Text content to write                                          |
| append     | bool       | Whether to append to existing file (true) or overwrite (false) |

**Example:**

=== "chili"

    ```chili
    wtxt("log.txt", "New entry", 1b);
    ```

=== "pepper"

    ```pepper
    wtxt["log.txt"; "New entry"; 1b]
    ```

## Partitioned Data Functions

### `wpar`

Writes a DataFrame as a partitioned dataframe, return the file size in bytes.

| Parameters   | Type        | Description                                                              |
| ------------ | ----------- | ------------------------------------------------------------------------ |
| hdb_path     | str or sym  | Base path for the HDB                                                    |
| partition    | date or i64 | Partition identifier (date or year 1000-3999)                            |
| table        | sym         | Table name                                                               |
| df           | dataframe   | DataFrame to write                                                       |
| sort_columns | syms        | Columns to sort by, but there is no attribute concept for parquet files. |
| rechunk      | bool        | Whether to rechunk and consolidate partitions                            |

!!! tip

    - Automatically creates table directories if they don't exist, but it won't create the hdb path.
    - Supports date and year-based partitioning
    - Automatically adds partition columns (`date` or `year`) if not present
    - Handles sub-partitioning with automatic numbering
    - Option to consolidate multiple sub-partitions into a single file

**Example:**

=== "chili"

    ```chili
    // Write to year-based partition
    size = wpar("/data/hdb", 2024, `prices, df, `symbol, 0b)

    // Write to date-based partition
    size = wpar("/data/hdb", 2024.01.15, `trades, df, `time, 0b)
    ```

=== "pepper"

    ```pepper
    // Write to year-based partition
    size = wpar["/data/hdb"; 2024; `prices; df; `symbol; 0b]

    // Write to date-based partition
    size = wpar["/data/hdb"; 2024.01.15; `trades; df; `time; 0b]
    ```

## Utility Functions

### `hdel`

Deletes a file.

| Parameters | Type       | Description                |
| ---------- | ---------- | -------------------------- |
| path       | str or sym | File path to the text file |

### `exists`

Checks if a file or directory exists.

| Parameters | Type       | Description                |
| ---------- | ---------- | -------------------------- |
| path       | str or sym | File path to the text file |
