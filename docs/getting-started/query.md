# Query

## Overview

`chili` incorporates a query syntax(similar to [qsql](https://code.kx.com/q/basics/qsql/)) for executing queries, and return the results as a DataFrame.

## Syntax

### Select

Syntax: `select [columns] [by columns] from dataframe [where condition] [limit n]`

Optional statements:

- columns
- by columns
- where condition
- limit n

=== "chili"

    ```chili
    // create a dataframe
    t: ([]sym:10?`a`b`c; qty: 10?1 2);

    // select all columns from the dataframe
    select from t;

    // select all columns from the dataframe where the quantity is greater than 1
    select from t where qty > 1;

    // select the symbol, quantity, and the total quantity by symbol
    select sym, qty, total_qty: sum(qty) fby sym from t;

    // select last row by symbol
    select by sym from t;

    // select the first row
    select from t limit 1;

    // select last row
    select from t limit -1;
    ```

=== "pepper"

    ```pepper
    // create a dataframe
    t: ([]sym:10?`a`b`c; qty: 10?1 2);

    // select all columns from the dataframe
    select from t;

    // select all columns from the dataframe where the quantity is greater than 1
    select from t where qty > 1;

    // select the symbol, quantity, and the total quantity by symbol
    select sym, qty, total_qty: sum[qty] fby sym from t;

    // select last row by symbol
    select by sym from t;

    // select the first row
    select from t limit 1;

    // select last row
    select from t limit -1;
    ```

### Update

Syntax: `update [columns] [by columns] from dataframe [where condition]`

Optional statements:

- columns
- by columns
- where condition

=== "chili"

    ```pepper
    // create a dataframe
    t: ([]sym:10?`a`b`c; qty: 10?1 2);

    // append a price column
    update price: 100 from t;

    // append a total quantity column by symbol
    update total_qty: sum qty by sym from t;

    // when condition then else
    update qty:when(sym=`c;5;qty) from t;

    // update the total quantity by symbol where the symbol is `c
    update sum qty by sym from t where sym=`c;
    ```

=== "pepper"

    ```pepper
    // create a dataframe
    t: ([]sym:10?`a`b`c; qty: 10?1 2);

    // append a price column
    update price: 100 from t;

    // append a total quantity column by symbol
    update total_qty: sum qty by sym from t;

    // when condition then else
    update qty:when[sym=`c;5;qty] from t;

    // update the total quantity by symbol where the symbol is `c
    update sum qty by sym from t where sym=`c;
    ```

### Delete

3 kinds of delete statements:

- delete from dataframe where condition
- delete columns from dataframe
- delete from dataframe

=== "chili"

    ```pepper
    // create a dataframe
    t: ([]sym:10?`a`b`c; qty: 10?1 2);

    // delete the quantity by symbol
    delete from t where sym = `a;

    // delete the quantity column
    delete qty from t;

    // truncate the dataframe
    delete from t;
    ```

=== "pepper"

    ```pepper
    // create a dataframe
    t: ([]sym:10?`a`b`c; qty: 10?1 2);

    // delete the quantity by symbol
    delete from t where sym = `a;

    // delete the quantity column
    delete qty from t;

    // truncate the dataframe
    delete from t;
    ```

## Join

### `aj`

As-of join.

| Parameters | Type      | Description        |
| ---------- | --------- | ------------------ |
| columns    | syms      | Columns to join on |
| df1        | dataframe | Left table         |
| df2        | dataframe | Right table        |

### `cj`

Returns the Cartesian product of rows from both tables

| Parameters | Type      | Description        |
| ---------- | --------- | ------------------ |
| columns    | syms      | Columns to join on |
| df1        | dataframe | Left table         |
| df2        | dataframe | Right table        |

### `ij`

Returns rows that have matching values in both tables.

| Parameters | Type      | Description        |
| ---------- | --------- | ------------------ |
| columns    | syms      | Columns to join on |
| df1        | dataframe | Left table         |
| df2        | dataframe | Right table        |

### `lj`

Returns all rows from the left table, and the matched rows from the right table.

| Parameters | Type      | Description        |
| ---------- | --------- | ------------------ |
| columns    | syms      | Columns to join on |
| df1        | dataframe | Left table         |
| df2        | dataframe | Right table        |

### `fj`

Returns all rows when there is a match in either left or right.

| Parameters | Description        |
| ---------- | ------------------ |
| columns    | Columns to join on |
| df1        | Left table         |
| df2        | Right table        |

### `wj`

Window join, it will sort df2 by `by_columns` and `time_column` and perform the join operation within the window defined by `[start_column, end_column)`.

| Parameters   | Type      | Description         |
| ------------ | --------- | ------------------- |
| by_columns   | syms      | Columns to join on  |
| time_column  | sym       | Time column         |
| start_column | sym       | Window start column |
| end_column   | sym       | Window end column   |
| aggregations | exprs     | Aggregations        |
| df1          | dataframe | Left table          |
| df2          | dataframe | Right table         |

=== "chili"

    ```chili
    t: ([]sym:`a`a`b`b, time: 1 2 3 4, end: 3 5 7 9, price: 1 2 3 4);

    q: ([]sym:`a`a`a`a`c`c`c`c, time: 1 2 3 4 5 6 7 8, ask: 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8f64);

    wj(`sym, `time, `time, `end, [], t, q);

    wj(`sym, `time, `time, `end, min(col(`ask)) as "min_ask", t, q);

    wj(`sym, `time, `time, `end, [min(col(`ask)) as "min_ask", max(col(`ask)) as "max_ask"], t, q);
    ```

=== "pepper"

    ```pepper
    t: ([]sym:`a`a`b`b; time: 1 2 3 4; end: 3 5 7 9; price: 1 2 3 4);

    q: ([]sym:`a`a`a`a`c`c`c`c; time: 1 2 3 4 5 6 7 8; ask: 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8f64);

    wj[`sym; `time; `time; `end; (); t; q];

    wj[`sym; `time; `time; `end; min[col["ask"]] as "min_ask"; t; q];

    wj[`sym; `time; `time; `end; (min[col["ask"]] as "min_ask"; max[col["ask"]] as "max_ask"); t; q];

    ```

### `anti`

Returns rows from the left table that have no match in the right table.

| Parameters | Description        |
| ---------- | ------------------ |
| columns    | Columns to join on |
| df1        | Left table         |
| df2        | Right table        |

### `semi`

Returns rows from the left table that have a match in the right table.

| Parameters | Type      | Description        |
| ---------- | --------- | ------------------ |
| columns    | syms      | Columns to join on |
| df1        | dataframe | Left table         |
| df2        | dataframe | Right table        |

## Functions

### `col`

Create a column name expression.

| Parameters  | Type | Description |
| ----------- | ---- | ----------- |
| column_name | sym  | Column name |

### `lit`

Create a literal expression.

| Parameters | Type | Description   |
| ---------- | ---- | ------------- |
| value      | any  | Literal value |

### `as`

Rename expression to a column name.

| Parameters  | Type | Description |
| ----------- | ---- | ----------- |
| expr        | expr | Expression  |
| column_name | sym  | Column name |

### `when`

If-else expression.

| Parameters | Type        | Description |
| ---------- | ----------- | ----------- |
| condition  | bool        | Condition   |
| then       | sym or expr | Then value  |
| else       | sym or expr | Else value  |

### `fby`

Group by and aggregate expression.

| Parameters | Type       | Description |
| ---------- | ---------- | ----------- |
| collection | collection | Collection  |
| group_by   | exprs      | Group by    |

### `within`

Check if a value is within a range.

| Parameters | Type       | Description    |
| ---------- | ---------- | -------------- |
| collection | collection | Collection     |
| range      | range      | Range to check |

### `.fn.select`

Executes a select query and returns the results as a DataFrame.

| Parameters | Type           | Description |
| ---------- | -------------- | ----------- |
| table      | sym            | Table       |
| partitions | dates or years | Partitions  |
| where      | exprs          | Where       |
| group_bys  | exprs          | Group bys   |
| operations | exprs          | Operations  |
| limit      | i64            | Limit       |

### `.fn.update`

Executes an update query.

| Parameters | Type  | Description |
| ---------- | ----- | ----------- |
| table      | sym   | Table       |
| where      | exprs | Where       |
| group_bys  | exprs | Group bys   |
| operations | exprs | Operations  |

### `.fn.delete`

Executes a delete query.

| Parameters | Type  | Description |
| ---------- | ----- | ----------- |
| table      | sym   | Table       |
| where      | exprs | Where       |
| columns    | syms  | Columns     |

## Functional Query Examples

Single quoted string is used for a column expression.

=== "chili"

    'column' is a shortcut for `col("column")`.

    ```chili
    // create a dataframe
    t: ([]time: range(100), sym: 100?`a`b`c, qty: 100?10 20 30 40 50, price: 100?1 2 3 4 5f);

    s: 'qty' wsum 'price' as "value";
    s: enlist(s) ++ ('qty' wmean 'price' as "vwap");
    g: [10 xbar 'time','sym'];

    .fn.update(t, [], g, s);

    w: 'sym' = `a;

    .fn.delete(t, w, []);

    w: enlist(w) ++ ('qty' = 20);
    .fn.select(t, [], w, [], [], 0);
    ```

=== "pepper"

    'column' is a shortcut for `col["column"]`.

    ```pepper
    // create a dataframe
    t: ([]time: range 100; sym: 100?`a`b`c; qty: 100?10 20 30 40 50; price: 100?1 2 3 4 5f);

    s: ('qty' wsum 'price') as "value";
    s: enlist[s] ++ ('qty' wmean 'price') as "vwap";
    g: (10 xbar 'time';'sym');

    .fn.update[t; (); g; s];

    w: 'sym' = `a;

    .fn.delete[t; w; ()]

    w: enlist[w] ++ 'qty' = 20;
    .fn.select[t; (); w; (); (); 0];
    ```
