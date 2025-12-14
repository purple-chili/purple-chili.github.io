# Job System

## Overview

The job system in `chili` provides a way to schedule, manage, and query background jobs. Each job is associated with a function to execute, a schedule (start/end/interval), and metadata such as description and activation status.

To start the job scheduler, you need to pass the `--interval` argument to the `chili` or `pepper` binary.

## Job Structure

A job is represented by the following fields:

| Field           | Type        | Description                                                    |
| --------------- | ----------- | -------------------------------------------------------------- |
| `fn_name`       | String      | Name of the function to execute                                |
| `start_time`    | i64         | Start time (timestamp, nanoseconds since Unix epoch)           |
| `end_time`      | i64         | End time (timestamp, nanoseconds since Unix epoch)             |
| `interval`      | i64         | Interval between runs (nanoseconds)                            |
| `last_run_time` | Option<i64> | Last run time (timestamp, nanoseconds), or `null` if never run |
| `next_run_time` | i64         | Next scheduled run time (timestamp, nanoseconds)               |
| `is_active`     | bool        | Whether the job is active                                      |
| `description`   | String      | Description of the job                                         |

## Functions

### `.job.list`

Returns a table (DataFrame) of all jobs and their properties.

| Parameters | Type | Description |
| ---------- | ---- | ----------- |
| None       | None | None        |

### `.job.add`

Adds a new recurring job and returns the job ID(i64).

| Parameters  | Type       | Description                                           |
| ----------- | ---------- | ----------------------------------------------------- |
| fn_name     | str or sym | Name of the function to execute                       |
| start_time  | timestamp  | Start time (nanoseconds)                              |
| end_time    | timestamp  | End time (nanoseconds)                                |
| interval    | duration   | Interval between runs (nanoseconds, must be positive) |
| description | str or sym | Description of the job                                |

**Example:**

=== "chili"

    ```chili
    .job.add(`my_fn, 2025.01.01D00:00:00.000000000, 2025.01.02D00:00:00.000000000, 0D01:00:00.000000000, "daily job");
    ```

=== "pepper"

    ```pepper
    .job.add["my_fn"; 2025.01.01D00:00:00.000000000; 2025.01.02D00:00:00.000000000; 0D01:00:00.000000000; "daily job"]
    ```

---

### `.job.add_after`

Adds a job to run once after a specified interval from now, and returns the job ID(i64).

| Parameters  | Type       | Description                                       |
| ----------- | ---------- | ------------------------------------------------- |
| fn_name     | str or sym | Name of the function to execute                   |
| interval    | duration   | Interval from now (nanoseconds, must be positive) |
| description | str or sym | Description of the job                            |

**Example:**

=== "chili"

    ```chili
    .job.add_after(`my_fn, 0D00:10:00.000000000, "run in 10 minutes");
    ```

=== "pepper"

    ```pepper
    .job.add_after["my_fn"; 0D00:10:00.000000000; "run in 10 minutes"]
    ```

### `.job.add_at_time`

Adds a job to run once at a specific time and returns the job ID(i64).

| Parameters  | Type       | Description                     |
| ----------- | ---------- | ------------------------------- |
| fn_name     | str or sym | Name of the function to execute |
| start_time  | timestamp  | Time to run (nanoseconds)       |
| description | str or sym | Description of the job          |

**Example:**

=== "chili"

    ```chili
    .job.add_at_time(`my_fn, 2025.01.01D12:00:00.000000000, "noon job");
    ```

=== "pepper"

    ```pepper
    .job.add_at_time["my_fn"; 2025.01.01D12:00:00.000000000; "noon job"]
    ```

### `.job.get`

Query jobs by ID or by pattern in the description.

| Parameters    | Type       | Description                      |
| ------------- | ---------- | -------------------------------- |
| id_or_pattern | int or str | Job ID or pattern in description |

### `.job.activate`

Activate job(s) by ID or by pattern in the description.

| Parameters    | Type       | Description                      |
| ------------- | ---------- | -------------------------------- |
| id_or_pattern | int or str | Job ID or pattern in description |

### `.job.deactivate`

Deactivate job(s) by ID or by pattern in the description.

| Parameters    | Type       | Description                      |
| ------------- | ---------- | -------------------------------- |
| id_or_pattern | int or str | Job ID or pattern in description |

### `.job.clear`

Remove all jobs from the system.

| Parameters | Type | Description |
| ---------- | ---- | ----------- |
| None       | None | None        |
