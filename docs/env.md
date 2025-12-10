# Environment Variables

## Set max threads

If max threads is not set, polars-engine will use all available threads(all cores) by default.

```bash
export POLARS_MAX_THREADS=6
```

## IPC related environment variables

- `CHILI_IPC_TOKEN`: If no password is provided, the connection uses this environment variable as the password (if set).

```bash
export CHILI_IPC_TOKEN=mysecretpassword
```

- `CHILI_NETWORK_BANDWIDTH`: Sets the network bandwidth in MB/s. If not set, defaults to 1000MB/s. The bandwidth value determines the IPC compression method.

```bash
export CHILI_NETWORK_BANDWIDTH=1000
```
