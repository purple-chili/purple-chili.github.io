# String

## Functions

### `concat`

Concatenate two strings.

| Parameters | Type | Description  |
| ---------- | ---- | ------------ |
| sep        | str  | Separator    |
| left       | str  | Left string  |
| right      | str  | Right string |

### `join`

Join a list of strings with a separator.

| Parameters | Type | Description     |
| ---------- | ---- | --------------- |
| separator  | str  | Separator       |
| strings    | list | List of strings |

### `lowercase`

Convert a string to lowercase.

| Parameters | Type | Description       |
| ---------- | ---- | ----------------- |
| string     | str  | String to convert |

### `match`

Match a string with a pattern.

| Parameters | Type | Description      |
| ---------- | ---- | ---------------- |
| strings    | list | List of strings  |
| pattern    | str  | Pattern to match |

### `pad`

Pad a string to a given length. A positive length pads on the right, a negative length on the left — for a string, a series, and a column inside a query alike.

| Parameters | Type | Description   |
| ---------- | ---- | ------------- |
| length     | i64  | Length to pad |
| string     | str  | String to pad |

### `replace`

Replace every match of a pattern (a regular expression) with a replacement — for a string, a series, and a column inside a query alike.

| Parameters  | Type | Description        |
| ----------- | ---- | ------------------ |
| strings     | list | List of strings    |
| pattern     | str  | Pattern to replace |
| replacement | str  | Replacement string |

### `split`

Split a string into a list of strings.

| Parameters | Type | Description     |
| ---------- | ---- | --------------- |
| separator  | str  | Separator       |
| string     | str  | String to split |

### `trim`

Trim whitespace from both ends of a string. `trim`, `trims` and `trime` behave the same on a string, a series, and a column inside a query.

| Parameters | Type | Description    |
| ---------- | ---- | -------------- |
| string     | str  | String to trim |

### `trime`

Trim a string from the end.

| Parameters | Type | Description                 |
| ---------- | ---- | --------------------------- |
| string     | str  | String to trim from the end |

### `trims`

Trim a string from the start.

| Parameters | Type | Description                   |
| ---------- | ---- | ----------------------------- |
| string     | str  | String to trim from the start |

### `uppercase`

Convert a string to uppercase.

| Parameters | Type | Description       |
| ---------- | ---- | ----------------- |
| string     | str  | String to convert |
