# Operators

## Overview

Operators are overloaded to work with various data types, including scalars, lists, dictionaries, series, matrices, and dataframes. Many operators are polymorphic and handle mixed types, nulls, and temporal values.

Below is a summary of the main operators, their symbols, and their behavior.

## Operator Table

| Character  | Function              | Description                                                                    |
| ---------- | --------------------- | ------------------------------------------------------------------------------ |
| =          | equal                 | Equality comparison                                                            |
| !=         | not equal             | Inequality comparison                                                          |
| >          | greater               | Greater than comparison                                                        |
| >=         | greater than or equal | Greater than or equal comparison                                               |
| <          | less                  | Less than comparison                                                           |
| <=         | less than or equal    | Less than or equal comparison                                                  |
| ~          | match                 | Exact match (deep equality, including collections)                             |
| @          | at                    | Indexing: apply to collections (like at)                                       |
| .          | apply                 | Indexing: apply multi-level indexing to collections                            |
| $          | cast                  | Type casting for values and collections                                        |
| ?          | rand                  | Random number generator for numbers, element-wise for collections              |
| !          | dict                  | Create dictionary from keys and values                                         |
| +          | add                   | Addition for numbers, concatenation for lists/series, temporal addition        |
| -          | minus                 | Subtraction for numbers, temporal difference                                   |
| \*         | muliply               | Multiplication for numbers, scaling for temporal, element-wise for collections |
| / `chili`  | divide                | Division for numbers, element-wise for collections                             |
| % `pepper` | divide                | Division for numbers, element-wise for collections                             |
| \|         | or                    | Logical or, max for numbers, element-wise for collections                      |
| &          | and                   | Logical and, min for numbers, element-wise for collections                     |
| #          | take                  | Take first/last N elements from collections                                    |
| ^          | fill                  | Fill nulls in collections with a value                                         |
| '          | raise                 | Raise an error with a message                                                  |
| \_         | remove                | Remove first/last N elements from collections                                  |
| ++         | append                | Concatenation for lists, series, dicts, dataframes                             |

???+ warning

    In `chili`, `/` is used for division, in `pepper`, `%` is used for division.

## Operator Details

### + (add)

- Adds numbers, concatenates lists/series, and supports temporal addition (e.g., date + duration).
- Handles mixed types and nulls.

### - (minus)

- Subtracts numbers, computes differences for temporal types (e.g., date - date = int).
- Handles mixed types and nulls.

### \* (muliply)

- Multiplies numbers, scales temporal types, element wise for lists/series/matrices.
- Handles mixed types and nulls.

### / `chili` or % `pepper` (divide)

- Divides numbers, element wise for lists/series/matrices.
- Handles mixed types and nulls.

### = (equal)

- Checks equality for numbers, strings, symbols, temporal, and collections.
- Returns boolean or boolean collection.

### != (not equal)

- Checks inequality (negation of eq).

### >, >=, <, <= (greater, greater than or equal, less, less than or equal)

- Comparison operators for numbers, temporal, and collections.
- Return boolean or boolean collection.

### ~ (match)

- Deep equality: checks if two values/collections are exactly the same.

### @ (at)

- Indexing: apply to collections (like at)

### . (apply)

- Indexing: apply multi-level indexing to collections

### $ (cast)

- Type casting for values and collections

### ! (dict)

- Create dictionary from keys and values

### ? (rand)

- Random number generator for numbers, element-wise for collections

### | (or)

- Logical or, max for numbers, elementwise for collections

### & (and)

- Logical and, min for numbers, elementwise for collections

### \_ (remove)

- Remove first/last N elements from collections

### ^ (fill)

- Fill nulls in collections with a value
