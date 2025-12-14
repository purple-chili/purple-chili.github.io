# Series

## Functions

### `asc`

Sort a series in ascending order.

| Parameters | Type   | Description    |
| ---------- | ------ | -------------- |
| series     | series | Series to sort |

### `bfill`

Fill missing values with the next non-null value.

| Parameters | Type   | Description    |
| ---------- | ------ | -------------- |
| series     | series | Series to fill |

### `bottom`

Get the bottom k values of a series.

| Parameters | Type   | Description                    |
| ---------- | ------ | ------------------------------ |
| k          | i64    | Number of bottom values to get |
| series     | series | Series to get values from      |

### `ccount`

Cumulative count the number of values in a series.

| Parameters | Type   | Description                        |
| ---------- | ------ | ---------------------------------- |
| series     | series | Series to perform cumulative count |

### `clip`

Clip a series to a given range.

| Parameters | Type   | Description    |
| ---------- | ------ | -------------- |
| series     | series | Series to clip |
| min        | any    | Minimum value  |
| max        | any    | Maximum value  |

### `cmin`

Cumulative minimum value of a series.

| Parameters | Type   | Description                          |
| ---------- | ------ | ------------------------------------ |
| series     | series | Series to perform cumulative minimum |

### `cmax`

Cumulative maximum value of a series.

| Parameters | Type   | Description                          |
| ---------- | ------ | ------------------------------------ |
| series     | series | Series to perform cumulative maximum |

### `csum`

Cumulative sum of a series.

| Parameters | Type   | Description                      |
| ---------- | ------ | -------------------------------- |
| series     | series | Series to perform cumulative sum |

### `cprod`

Cumulative product of a series.

| Parameters | Type   | Description                          |
| ---------- | ------ | ------------------------------------ |
| series     | series | Series to perform cumulative product |

### `desc`

Sort a series in descending order.

| Parameters | Type   | Description    |
| ---------- | ------ | -------------- |
| series     | series | Series to sort |

### `diff`

Difference between consecutive values in a series.

| Parameters | Type   | Description                   |
| ---------- | ------ | ----------------------------- |
| series     | series | Series to get difference from |

### `differ`

Difference between two series.

| Parameters | Type   | Description                          |
| ---------- | ------ | ------------------------------------ |
| p1         | series | Set of values to get difference from |
| p2         | series | Set of values to get difference from |

### `fill`

Fill missing values with the previous non-null value.

| Parameters | Type   | Description    |
| ---------- | ------ | -------------- |
| series     | series | Series to fill |

### `filter`

Convert a boolean series to indices.

| Parameters | Type   | Description       |
| ---------- | ------ | ----------------- |
| series     | series | Series to convert |

e.g. `010101b` -> `0 2 4`

### `first`

Get the first value of a series.

| Parameters | Type   | Description                    |
| ---------- | ------ | ------------------------------ |
| series     | series | Series to get first value from |

### `in`

Check if a value is in a set.

| Parameters | Type       | Description         |
| ---------- | ---------- | ------------------- |
| collection | collection | Collection to check |
| values     | collection | Values to check     |

### `interp`

Interpolate missing values with a linear interpolation.

| Parameters | Type   | Description           |
| ---------- | ------ | --------------------- |
| series     | series | Series to interpolate |

### `intersect`

Intersection of two series.

| Parameters | Type   | Description                     |
| ---------- | ------ | ------------------------------- |
| p1         | series | Series to get intersection from |
| p2         | series | Series to get intersection from |

### `last`

Get the last value of a series.

| Parameters | Type   | Description                   |
| ---------- | ------ | ----------------------------- |
| series     | series | Series to get last value from |

### `like`

Check if a string is like a pattern.

| Parameters | Type | Description      |
| ---------- | ---- | ---------------- |
| strings    | list | List of strings  |
| pattern    | str  | Pattern to match |

### `next`

Shift the series by one position.

| Parameters | Type   | Description     |
| ---------- | ------ | --------------- |
| series     | series | Series to shift |

### `not`

Negate a boolean series.

| Parameters | Type   | Description      |
| ---------- | ------ | ---------------- |
| series     | series | Series to negate |

### `prev`

Shift the series by one position backwards.

| Parameters | Type   | Description     |
| ---------- | ------ | --------------- |
| series     | series | Series to shift |

### `rank`

Rank the values in a series.

| Parameters | Type   | Description    |
| ---------- | ------ | -------------- |
| series     | series | Series to rank |

### `reverse`

Reverse the values in a series.

| Parameters | Type   | Description       |
| ---------- | ------ | ----------------- |
| series     | series | Series to reverse |

### `rotate`

Rotate the values in a series.

| Parameters | Type       | Description                   |
| ---------- | ---------- | ----------------------------- |
| n          | i64        | Number of positions to rotate |
| collection | collection | Collection to rotate          |

### `shift`

Shift the values in a series.

| Parameters | Type       | Description                  |
| ---------- | ---------- | ---------------------------- |
| n          | i64        | Number of positions to shift |
| collection | collection | Collection to shift          |

### `shuffle`

Shuffle the values in a series.

| Parameters | Type       | Description           |
| ---------- | ---------- | --------------------- |
| collection | collection | Collection to shuffle |

### `ss`

Find the leftmost indices where elements should be inserted to maintain order.

| Parameters    | Type       | Description             |
| ------------- | ---------- | ----------------------- |
| collection    | collection | Collection to search in |
| search_values | collection | Values to search for    |

### `ssr`

Find the rightmost indices where elements should be inserted to maintain order.

| Parameters    | Type       | Description             |
| ------------- | ---------- | ----------------------- |
| collection    | collection | Collection to search in |
| search_values | collection | Values to search for    |

### `top`

Get the top k values of a series.

| Parameters | Type   | Description                 |
| ---------- | ------ | --------------------------- |
| k          | i64    | Number of top values to get |
| series     | series | Series to get values from   |

### `uc`

Count unique values in a series.

| Parameters | Type   | Description                        |
| ---------- | ------ | ---------------------------------- |
| series     | series | Series to count unique values from |

### `union`

Union of two series.

| Parameters | Type   | Description              |
| ---------- | ------ | ------------------------ |
| p1         | series | Series to get union from |
| p2         | series | Series to get union from |

### `unique`

Get unique values in a series.

| Parameters | Type   | Description                      |
| ---------- | ------ | -------------------------------- |
| series     | series | Series to get unique values from |

### `xbar`

Assign bars to each element in a series.

| Parameters | Type   | Description              |
| ---------- | ------ | ------------------------ |
| bar_size   | i64    | Size of the bar          |
| series     | series | Series to assign bars to |
