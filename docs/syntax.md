# Syntax

There are two styles of coding syntax: `chili` and `pepper`.

- `chili` is a modern syntax, more amiable to other developers using other languages, especially `javascript`.
- `pepper` is a vintage syntax, similar to `q`.

## Syntax Configuration for Vim

Vim configuration files are located in [vim-config](https://github.com/purple-chili/chili/tree/main/vim-config).

Just copy the files to the `~/.vim` directory.

## Evaluation Order

!!! tip

    There is no precedence for operators in `chili`, which means `+`, `*` have the same precedence.

=== "chili"

    Statements are evaluated <span style="color:purple; font-weight: bold;">from left to right</span> . `.e.g` `2+3*4+5` is evaluated as `((2+3)*4)+5`.

=== "pepper"

     Statements are evaluated <span style="color:purple; font-weight: bold;">from right to left</span>. `.e.g` `2+3*4+5` is evaluated as `2+(3*(4+5))`.

## Import

To import source files, use `import` function. Using `CHILI_PKG_PATH` environment variable(Pending), it is used to resolve the `import` path. `CHILI_PKG_PATH` uses `~/chili` by default.

- relative path has to be started with `./` or `../`
- absolute path has to be started with `/`
- path starts from `CHILI_PKG_PATH` has to be started with `@` or alphabetical characters

!!! info "Package Path(Pending)"

    A typical source file from package path looks like `$CHILI_PKG_PATH/pkg/v0.0.0/src/code.chi`, and the import code is `import("pkg/code.chi")`.

=== "chili"

    ``` chili
    import("./src.jx");
    import("../util.jx");
    import("/tmp/src.jx");
    ```

=== "pepper"

    ``` pepper
    import "./src.jx";
    import "../util.jx";
    import "/tmp/src.jx";
    ```

## Comments

Same for both syntaxes.

=== "chili"

    ``` chili
    // line comment

    /*
      block of comments
    */
    ```

=== "pepper"

    ``` pepper
    // line comment

    /*
      block of comments
    */
    ```

## Variables

Starts with a letter, followed by letters, digits, or underscores.
Global variables are prefixed with a dot.
Same for both syntaxes.

=== "chili"

    ```chili
    a
    a_b
    a_b_c
    .a
    .a.b
    .a.b.c
    ```

=== "pepper"

    ```pepper
    a
    a_b
    a_b_c
    .a
    .a.b
    .a.b.c
    ```

## Assignment

Assign a value to a variable, unlike other languages, this also returns the assigned value.

=== "chili"

    ```chili
    a: 1;
    d: {};
    d(`key): "value";
    ```

=== "pepper"

    ```pepper
    a: 1;
    d: {};
    d[`key]: "value";
    ```

## Control Flow

### If

=== "chili"

    ```chili
    // no semicolon at the end of the statement
    if(condition) {
      statement;
      statement;
      ...
    }

    // if else
    if(condition) {
      statement;
      statement;
      ...
    } else if(condition) {
      statement;
      statement;
      ...
    } else {
      statement;
      statement;
      ...
    }
    ```

=== "pepper"

    ```pepper
    // required semicolon at the end of the statement
    if[condition;
      statement;
      statement;
      ...
    ];
    ```

### If Else Short-hand

This is an expression, not a statement, which requires a semicolon to separate with next statement.

=== "chili"

    ```chili
    if {condition; value_for_true; value_for_false};

    if {
      condition1;
        value_for_true1;
      condition2;
        value_for_true2;
      ...
      conditionN;
        value_for_trueN;
        value_for_falseN;
    };

    ```

=== "pepper"

    ```pepper
    $[condition; value_for_true; value_for_false];

    $[condition1;
        value_for_true1;
      condition2;
        value_for_true2;
      ...
      conditionN;
        value_for_trueN;
        value_for_falseN;
    ];
    ```

### While

=== "chili"

    ```chili
    while(condition) {
      statement;
      statement;
      ...
    }
    ```

=== "pepper"

    ```pepper
    while[condition;
      statement;
      statement;
      ...
    ];
    ```

### Try

=== "chili"

    ```chili
    // no semicolon at the end of the statement
    try {
      statement;
      statement;
      ...
    } catch (e) {
      // error message is in the e variable
      statement;
      statement;
      ...
    }
    ```

=== "pepper"

    ```pepper
    // required semicolon at the end of the statement
    try [
      statement;
      statement;
      ...
    ] catch [
      // error message is in the err variable
      statement;
      statement;
      ...
    ];
    ```

## Functions

### Function Definition

=== "chili"

    For chili syntax, `function`, `return`, `raise` are keywords.

    ```chili
    f: function(param1, param2, ...) {
      statement;
      statement;
      return value;
      raise "error";
      ...
    };
    ```

=== "pepper"

    Single quotation `'` is used for creating a column expression.

    For pepper syntax, `:` is used to return a value from a function, `raise` is used to raise an error.

    ```pepper
    f: {[param1; param2; ...]
      statement;
      statement;
      :value;
      raise "error";
      ...
    };
    ```

### Function Call

=== "chili"

    ```chili
    f(arg1, arg2, ...);
    ```

=== "pepper"

    ```pepper
    f[arg1; arg2; ...];
    ```
