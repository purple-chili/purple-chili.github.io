# Temporal

## Overview

The temporal functions in chili provide utilities for working with dates, times, and timestamps. These functions support timezone-aware operations and return values in the appropriate chili data types.

## Basic Literals

- date: `2025.01.01`
- time(nanoseconds): `01:00:00.000000000`
- datetime(milliseconds): `2025.01.01T01:00:00.000`
- timestamp(nanoseconds): `2025.01.01D01:00:00.000000000`
- duration(nanoseconds): `01:00:00.000000000`

## Functions

### `now`

Returns the current timestamp in nanoseconds since the Unix epoch (1970-01-01T00:00:00Z).

| Parameters | Type | Description |
| ---------- | ---- | ----------- |
| timezone   | sym  | Timezone    |

!!! note

    - When `timezone` is an empty string `""`, returns the current local time as a timestamp
    - When `timezone` is a valid timezone string (e.g., `"UTC"`, `"America/New_York"`, `"Asia/Tokyo"`), returns the current time in that timezone
    - When `timezone` is invalid, returns an error

=== "chili"

    ```chili
    // Get current local time
    now("");
    // Get current UTC time
    now("UTC");
    // Get current time in specific timezone
    now("America/New_York");
    now("Asia/Tokyo");
    now("Europe/London");
    ```

=== "pepper"

    ```pepper
    // Get current local time
    now[""];
    // Get current UTC time
    now["UTC"];
    // Get current time in specific timezone
    now["America/New_York"];
    now["Asia/Tokyo"];
    now["Europe/London"];
    ```

### `today`

Returns the current date as days since the Unix epoch (1970-01-01).

| Parameters | Type | Description |
| ---------- | ---- | ----------- |
| timezone   | sym  | Timezone    |

!!! note

    - When `timezone` is an empty string `""`, returns the current local date
    - When `timezone` is a valid timezone string, returns the current date in that timezone
    - When `timezone` is invalid, returns an error

=== "chili"

    ```chili
    // Get current local date
    today("");
    // Get current date in UTC
    today("UTC");
    // Get current date in specific timezone
    today("America/New_York");
    today("Asia/Tokyo");
    today("Europe/London");
    ```

=== "pepper"

    ```pepper
    // Get current local date
    today[""];
    // Get current date in UTC
    today["UTC"];
    // Get current date in specific timezone
    today["America/New_York"];
    today["Asia/Tokyo"];
    today["Europe/London"];
    ```

### `tz`

Converts a timestamp to a different timezone.

Across a daylight-saving change a wall-clock time can be ambiguous or not exist. `tz`, `local` and `utc` resolve both cases instead of failing: a time that happened twice (clocks went back) is taken as the earlier one, and a time that never happened (clocks went forward over it) is shifted forward by the length of the gap.

| Parameters | Type       | Description              |
| ---------- | ---------- | ------------------------ |
| timestamp  | timestamp  | Timestamp to convert     |
| from_tz    | sym or str | Timezone to convert from |
| to_tz      | sym or str | Timezone to convert to   |

=== "chili"

    ```chili
    tz(2025.01.01T00:00:00.000, "America/New_York", "Asia/Tokyo");
    ```

=== "pepper"

    ```pepper
    tz[2025.01.01T00:00:00.000; "America/New_York"; "Asia/Tokyo"];
    ```

### `local`

Converts a timestamp from UTC to the local timezone.

| Parameters | Type       | Description            |
| ---------- | ---------- | ---------------------- |
| timestamp  | timestamp  | Timestamp to convert   |
| timezone   | sym or str | Timezone to convert to |

=== "chili"

    ```chili
    local(2025.01.01T00:00:00.000, "America/New_York");
    ```

=== "pepper"

    ```pepper
    local[2025.01.01T00:00:00.000; "America/New_York"];
    ```

### `setz`

Attach a timezone label to a datetime/timestamp **without converting** the
underlying clock values (Polars dtype metadata only). Use this to make a naive
`D` / `T` literal comparable to a tz-aware column.

| Parameters | Type                | Description                          |
| ---------- | ------------------- | ------------------------------------ |
| timezone   | sym or str          | Timezone to attach (e.g. `"UTC"`)    |
| timestamp  | datetime/timestamp  | Value to label                       |

=== "chili"

    ```chili
    // Compare a UTC column to a naive timestamp literal
    select from trade where time > setz("UTC", 2026.08.25D00:00:00);
    ```

=== "pepper"

    ```pepper
    // Compare a UTC column to a naive timestamp literal
    select from trade where time > setz[`UTC; 2026.08.25D00:00:00];
    ```

### `utc`

Converts a timestamp to UTC.

| Parameters | Type       | Description            |
| ---------- | ---------- | ---------------------- |
| timestamp  | timestamp  | Timestamp to convert   |
| timezone   | sym or str | Timezone to convert to |

=== "chili"

    ```chili
    utc(2025.01.01T00:00:00.000, "America/New_York");
    ```

=== "pepper"

    ```pepper
    utc[2025.01.01T00:00:00.000; "America/New_York"];
    ```
