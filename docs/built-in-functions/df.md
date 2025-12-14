# DataFrame

## Functions

### `cols`

Get the columns of a dataframe.

| Parameters | Type | Description                   |
| ---------- | ---- | ----------------------------- |
| df         | df   | DataFrame to get columns from |

### `describe`

Get the description of a dataframe.

| Parameters | Type | Description                       |
| ---------- | ---- | --------------------------------- |
| df         | df   | DataFrame to get description from |

### `explode`

Explode a dataframe by a list of rows.

| Parameters | Type | Description          |
| ---------- | ---- | -------------------- |
| df         | df   | DataFrame to explode |
| columns    | list | Columns to explode   |

### `extend`

Extend a dataframe with another dataframe without rechunking.

| Parameters | Type | Description      |
| ---------- | ---- | ---------------- |
| df1        | df   | First dataframe  |
| df2        | df   | Second dataframe |

### `flag`

Check if the sort flag with series.

| Parameters | Type   | Description     |
| ---------- | ------ | --------------- |
| series     | series | Series to check |

### `flip`

Flip a dictionary into a dataframe.

| Parameters | Type | Description        |
| ---------- | ---- | ------------------ |
| dict       | dict | Dictionary to flip |

### `hstack`

Horizontally stack two dataframes.

| Parameters | Type | Description      |
| ---------- | ---- | ---------------- |
| df1        | df   | First dataframe  |
| df2        | df   | Second dataframe |

### `pivot`

Pivot a dataframe.

| Parameters  | Type | Description               |
| ----------- | ---- | ------------------------- |
| df          | df   | DataFrame to pivot        |
| indices     | list | Indices to pivot          |
| on_cols     | list | Columns to pivot          |
| values      | list | Values to pivot           |
| agg_fn_name | sym  | Aggregation function name |

### `schema`

Get the schema of a dataframe.

| Parameters | Type | Description                  |
| ---------- | ---- | ---------------------------- |
| df         | df   | DataFrame to get schema from |

### `transpose`

Transpose a dataframe.

| Parameters | Type | Description            |
| ---------- | ---- | ---------------------- |
| df         | df   | DataFrame to transpose |

### `unpivot`

Unpivot a dataframe.

| Parameters | Type | Description          |
| ---------- | ---- | -------------------- |
| df         | df   | DataFrame to unpivot |
| indices    | list | Indices to unpivot   |
| on_cols    | list | Columns to unpivot   |

### `vstack`

Vertically stack two dataframes.

| Parameters | Type | Description      |
| ---------- | ---- | ---------------- |
| df1        | df   | First dataframe  |
| df2        | df   | Second dataframe |

### `xasc`

Sort a dataframe in ascending order.

| Parameters | Type | Description       |
| ---------- | ---- | ----------------- |
| columns    | list | Columns to sort   |
| df         | df   | DataFrame to sort |

### `xdesc`

Sort a dataframe in descending order.

| Parameters | Type | Description       |
| ---------- | ---- | ----------------- |
| columns    | list | Columns to sort   |
| df         | df   | DataFrame to sort |

### `xrename`

Rename columns of a dataframe.

| Parameters | Type | Description         |
| ---------- | ---- | ------------------- |
| columns    | list | Columns to rename   |
| df         | df   | DataFrame to rename |

### `xreorder`

Reorder columns of a dataframe.

| Parameters | Type | Description          |
| ---------- | ---- | -------------------- |
| columns    | list | Columns to reorder   |
| df         | df   | DataFrame to reorder |

### `upsert`

Upsert rows into a dataframe in global state. It will set the dataframe to the id if it doesn't exist. This a thread safe operation.

| Parameters | Type       | Description               |
| ---------- | ---------- | ------------------------- |
| id         | str or sym | Id of the value to upsert |
| df         | dataframe  | DataFrame to upsert       |

### `insert`

Insert rows into a dataframe in global state. It will set the dataframe to the id if it doesn't exist. Also, it will keep the last row by key columns. This is a thread safe operation.

| Parameters | Type       | Description                        |
| ---------- | ---------- | ---------------------------------- |
| id         | str or sym | Id of the dataframe to insert into |
| by         | str or sym | Key columns                        |
| df         | dataframe  | dataframe to insert                |
