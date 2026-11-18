# Config

Configure dataframe display and automatic compaction.

## Functions

### `console`

Control how many rows and columns of a dataframe are printed to the console.

| Parameters | Type | Description      |
| ---------- | ---- | ---------------- |
| rows       | list | Rows to print    |
| cols       | list | Columns to print |

### `.compact.configure`

Configure automatic compaction of symbol-form `vstack` buffers. Call
`.compact.configure[interval_ms; target_rows]` (pepper) or
`.compact.configure(interval_ms, target_rows)` (chili). Returns null.

- `interval_ms` is a non-negative integer: milliseconds between worker passes,
  default 250. Zero disables future passes; an in-flight pass may finish.
- `target_rows` is a positive integer: the grouping target for merging small
  chunks, default 65,536. Already-large chunks retain their buffers.

Configuration applies to the engine. The worker starts on the first nonempty
symbol-form `vstack` append and is independent of the job scheduler. Re-enabling
it also schedules tables with pending append work. `shutdown()` stops the worker
and waits for its running pass; configuration after shutdown is rejected.

Python exposes `engine.set_auto_compaction(interval_ms=250, target_rows=65536)`
and constructor options `ChiliEngine(compaction_interval=250,
compaction_target_rows=65536)`.

Compaction does not implement retention or a hard latency guarantee. See
[`compact`](df.md#compact) for snapshot behavior and the interaction with frequent
table-replacing trims, and [`upsertn`](df.md#upsertn) for bounded retention.

## Python extension allocator on macOS

From 0.11.5, the macOS Python extension uses Rust's system allocator rather
than mimalloc v3. This addresses the allocator-recursion path reported during
engine construction in mixed parallel workloads. The affected full macOS suite
subsequently passed on 0.11.5. Python extensions on other platforms and the CLI
retain mimalloc; Python's own allocator is unchanged.

The repository's manual `macOS Python Candidate` GitHub Actions workflow
builds an ARM64 wheel and runs the Python tests with eight workers on Python
3.14 and Polars 1.39.3. The wheel is uploaded as an artifact for validation
against the affected application suite; the workflow does not publish to PyPI.

## Process memory reporting

Process-memory metrics are best effort. Python
`stats()["process_memory_rss_bytes"]` returns `-1` when the process metrics
cannot be initialized or read. `.os.mem` reports an error if system information
is unavailable. The configured memory monitor logs a warning and stops if
initialization fails or the process cannot be found.

## Late imports on Linux

From 0.11.6, the non-macOS Python extension enables mimalloc's
`local_dynamic_tls` feature. Linux late imports no longer require the loader
to fit the extension into glibc's spare static TLS block. Consumers do not need
an early `import chili` or a `GLIBC_TUNABLES` setting for this allocation path.
The CLI's allocator configuration is unchanged.

Linux wheel release jobs inspect the built extension's TLS relocations before
uploading artifacts. `PT_TLS` segment size alone is not an adequate check:
dynamic TLS uses that segment too. The audit rejects mandatory initial-exec
TLS relocations on x86_64 and ARM64.

The manual `Linux Python Candidate` workflow builds wheels on native x86_64
and ARM64 runners, audits the binaries, and tests late imports under synthetic
static-TLS pressure before running the full Python suite with eight workers.
It uploads candidate wheels without publishing to PyPI. Validation against
the originally affected ARM64 application suite is still required.
