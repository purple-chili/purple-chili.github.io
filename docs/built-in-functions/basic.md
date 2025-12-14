# Basic

## Functions

### `count`

Count the number of elements in a collection.

| Parameters | Type       | Description         |
| ---------- | ---------- | ------------------- |
| collection | collection | Collection to count |

### `del`

Delete an element from global state.

| Parameters | Type | Description                 |
| ---------- | ---- | --------------------------- |
| id         | any  | Id of the element to delete |

### `each`

Apply a function to each element in a collection.

| Parameters | Type       | Description                         |
| ---------- | ---------- | ----------------------------------- |
| f          | function   | Function to apply                   |
| collection | collection | Collection to apply the function to |

### `cross`

Cross two collections.

| Parameters | Type       | Description                |
| ---------- | ---------- | -------------------------- |
| p1         | collection | First collection to cross  |
| p2         | collection | Second collection to cross |

### `enlist`

Enlist a value into a collection.

| Parameters | Type | Description     |
| ---------- | ---- | --------------- |
| value      | any  | Value to enlist |

### `eval`

Evaluate a list and output.

| Parameters | Type | Description      |
| ---------- | ---- | ---------------- |
| list       | list | List to evaluate |

### `evalc`

Evaluate a expression list and output the result as string.

| Parameters | Type   | Description        |
| ---------- | ------ | ------------------ |
| string     | string | String to evaluate |

### `evali`

Evaluate a expression list and limit the number of rows to output.

| Parameters | Type   | Description        |
| ---------- | ------ | ------------------ |
| string     | string | String to evaluate |
| limit      | i64    | Limit to evaluate  |

### `exists`

Check if a path exists in file system.

| Parameters | Type       | Description   |
| ---------- | ---------- | ------------- |
| path       | str or sym | Path to check |

### `exit`

Exit the current process.

| Parameters | Type | Description |
| ---------- | ---- | ----------- |
| exit_code  | i64  | Exit code   |

### `flatten`

Flatten a collection of collections.

| Parameters | Type       | Description           |
| ---------- | ---------- | --------------------- |
| collection | collection | Collection to flatten |

### `get`

Get a value from global state.

| Parameters | Type | Description            |
| ---------- | ---- | ---------------------- |
| id         | any  | Id of the value to get |

### `import`

Import a source file.

| Parameters | Type       | Description                       |
| ---------- | ---------- | --------------------------------- |
| path       | str or sym | Path to the source file to import |

### `list`

List variables in global state matched with a pattern.

| Parameters | Type       | Description                |
| ---------- | ---------- | -------------------------- |
| pattern    | str or sym | Pattern to match variables |

### `load`

Load a partitioned dataframe directory.

| Parameters | Type       | Description                                         |
| ---------- | ---------- | --------------------------------------------------- |
| hdb_path   | str or sym | Path to the partitioned dataframe directory to load |

### `null`

check if a value is null.

| Parameters | Type | Description               |
| ---------- | ---- | ------------------------- |
| value      | any  | Value to check if is null |

### `over`

Apply a function to over to each element in a collection and return the last result.

| Parameters | Type       | Description                            |
| ---------- | ---------- | -------------------------------------- |
| f          | function   | Function to apply                      |
| init_value | any        | Initial value to apply the function to |
| collection | collection | Collection to apply the function to    |

### `par`

Get a partitioned dataframe value from global state.

| Parameters | Type | Description                              |
| ---------- | ---- | ---------------------------------------- |
| name       | sym  | Name of the partitioned dataframe to get |

### `parallel`

Apply a function to each element in a collection in parallel.

| Parameters | Type       | Description                         |
| ---------- | ---------- | ----------------------------------- |
| f          | function   | Function to apply                   |
| collection | collection | Collection to apply the function to |

### `range`

Generate a range of values.

| Parameters | Type   | Description                       |
| ---------- | ------ | --------------------------------- |
| series     | series | Series to generate the range from |

=== "chili"

    ```chili
    range(10);
    // exclude the right boundary
    range(5 10);
    // contains the right boundary
    range(2025.01.01 2025.12.31);
    ```

=== "pepper"

    ```pepper
    range[10];
    // exclude the right boundary
    range[5 10];
    // contains the right boundary
    range[2025.01.01 2025.12.31];
    ```

### `scan`

Apply a function to scan to each element in a collection and return the result as a collection.

| Parameters | Type       | Description                            |
| ---------- | ---------- | -------------------------------------- |
| f          | function   | Function to apply                      |
| init_value | any        | Initial value to apply the function to |
| collection | collection | Collection to apply the function to    |

### `set`

Set a value to global state.

| Parameters | Type | Description            |
| ---------- | ---- | ---------------------- |
| id         | any  | Id of the value to set |
| value      | any  | Value to set           |

### `show`

Print the value to the console and return the value.

| Parameters | Type | Description             |
| ---------- | ---- | ----------------------- |
| id         | any  | Id of the value to show |

### `tables`

List all dataframe names in global state starting with a prefix.

| Parameters | Type       | Description                                 |
| ---------- | ---------- | ------------------------------------------- |
| start_with | str or sym | Start with the prefix of the dataframe name |

### `timeit`

Measure the execution time of a list of expressions.

| Parameters | Type | Description                    |
| ---------- | ---- | ------------------------------ |
| list       | list | List of expressions to measure |
| times      | i64  | Number of times to measure     |

### `type`

Get the type name of a value.

| Parameters | Type | Description              |
| ---------- | ---- | ------------------------ |
| value      | any  | Value to get the type of |
