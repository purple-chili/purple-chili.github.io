# Operating System Operations

## Functions

### `.os.sleep`

Suspends execution for a specified number of milliseconds.

| Parameters | Type | Description                     |
| ---------- | ---- | ------------------------------- |
| ms         | i64  | Number of milliseconds to sleep |

### `.os.glob`

Expands a glob pattern and returns file information as a DataFrame.

| Parameters | Type       | Description                                            |
| ---------- | ---------- | ------------------------------------------------------ |
| path       | str or sym | Glob pattern to expand (e.g., "\*.txt", "data/\*.csv") |

**Example:**

=== "chili"

    ```chili
    // Get all CSV files in current directory
    files: .os.glob("*.csv");

    // Get all files recursively in data directory
    all_files: .os.glob("data/**/*");
    ```

=== "pepper"

    ```pepper
    // Get all CSV files in current directory
    files: .os.glob["*.csv"];

    // Get all files recursively in data directory
    all_files: .os.glob["data/**/*"];
    ```

### `.os.setenv`

Sets an environment variable.

| Parameters | Type       | Description                |
| ---------- | ---------- | -------------------------- |
| name       | str or sym | Environment variable name  |
| value      | str or sym | Environment variable value |

**Example:**

=== "chili"

    ```chili
    // Set environment variable
    .os.setenv("DEBUG", "1");
    // Set database connection string
    .os.setenv("DB_URL", "postgresql://user:pass@localhost/db");
    ```

=== "pepper"

    ```pepper
    // Set environment variable
    .os.setenv["DEBUG"; "1"]

    // Set database connection string
    .os.setenv["DB_URL"; "postgresql://user:pass@localhost/db"]
    ```

### `.os.seed`

Sets the global random seed for reproducible random number generation.

| Parameters | Type | Description       |
| ---------- | ---- | ----------------- |
| seed       | i64  | Random seed value |

**Example:**

=== "chili"

    ```chili
    // Set random seed for reproducible results
    .os.seed(42);

    // Generate random numbers (will be consistent with seed 42)
    random_values: 10?100;
    ```

=== "pepper"

    ```pepper
    // Set random seed for reproducible results
    .os.seed[42];

    // Generate random numbers (will be consistent with seed 42)
    random_values: 10?100;
    ```

### `.os.system`

Executes a system command and returns its output.

| Parameters | Type       | Description               |
| ---------- | ---------- | ------------------------- |
| command    | str or sym | System command to execute |

**Example:**

=== "chili"

    ```chili
    // List files in current directory
    files: .os.system("ls -la");

    // Get system information
    info: .os.system("uname -a");

    // Check disk usage
    usage: .os.system("df -h");
    ```

=== "pepper"

    ```pepper
    // List files in current directory
    files: .os.system["ls -la"];

    // Get system information
    info: .os.system["uname -a"];

    // Check disk usage
    usage: .os.system["df -h"];
    ```

### `.os.getenv`

Retrieves the value of an environment variable.

| Parameters | Type       | Description               |
| ---------- | ---------- | ------------------------- |
| name       | str or sym | Environment variable name |

**Example:**

=== "chili"

    ```chili
    // Get user's home directory
    home: .os.getenv("HOME");

    // Get current working directory
    pwd: .os.getenv("PWD");

    // Check if DEBUG is set
    debug: .os.getenv("DEBUG");
    ```

=== "pepper"

    ```pepper
    // Get user's home directory
    home: .os.getenv["HOME"];

    // Get current working directory
    pwd: .os.getenv["PWD"];

    // Check if DEBUG is set
    debug: .os.getenv["DEBUG"];
    ```

## `.os.mem`

Retrieves the memory usage of the current process and the system available memory.

| Parameters | Type | Description |
| ---------- | ---- | ----------- |
| None       | None | None        |

**Example:**

=== "chili"

    ```chili
    // Get memory usage
    .os.mem();
    ```

=== "pepper"

    ```pepper
    // Get memory usage
    .os.mem[];
    ```
