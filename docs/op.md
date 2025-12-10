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
| ??         | nullish coalescing    | returns its right-hand side operand when its left-hand side operand is null    |
| ?          | rand                  | Random number generator for numbers, element-wise for collections              |
| !          | dict                  | Create dictionary from keys and values                                         |
| +          | add                   | Addition for numbers, concatenation for lists/series, temporal addition        |
| -          | minus                 | Subtraction for numbers, temporal difference                                   |
| \*         | muliply               | Multiplication for numbers, scaling for temporal, element-wise for collections |
| / `chili`  | divide                | Division for numbers, element-wise for collections                             |
| % `pepper` | divide                | Division for numbers, element-wise for collections                             |
| \|\|       | logical or            | if either side is true, return true, otherwise return false(short-circuit)     |
| \|         | or                    | Logical or, max for numbers, element-wise for collections                      |
| &&         | logical and           | if both sides are true, return true, otherwise return false(short-circuit)     |
| &          | and                   | Logical and, min for numbers, element-wise for collections                     |
| #          | take                  | Take first/last N elements from collections                                    |
| ^          | fill                  | Fill nulls in collections with a value                                         |
| '`pepper`  | raise                 | Raise an error with a message                                                  |
| \_         | remove                | Remove first/last N elements from collections                                  |
| ++         | append                | Concatenation for lists, series, dicts, dataframes                             |

???+ warning

    In `chili`, `/` is used for division, in `pepper`, `%` is used for division.

???+ tip "Short-circuit operators"

    `??`, `||`, `&&` are **short-circuit** operators, which means the right-hand side operand is not evaluated if the left-hand side operand is enough to determine the result.

    ```chili
    // if a is null, return b, otherwise return a
    a ?? b;

    // if a is true, return a, otherwise return b
    a || b;

    // if a is false, return a, otherwise return b
    a && b;
    ```

    After all, these are operators, which follow the evaluation order of each language.
