# Real-time case

## Overview

This example shows how to use `chili` to build a real-time data pipeline.

```mermaid
graph TD
    PUB[**Publisher** pub.pep]
    SUB[**Subscriber** sub.pep]
    TICK[**Message Broker** tick.pep]

    PUB --> TICK
    TICK --> SUB

    style PUB fill:#7E57C2
    style SUB fill:#7E57C2
    style TICK fill:#D32F2F
```

=== "tick.pep"

    Start a message broker instance, listen at port 18000.

    ```bash
    pepper ./src/pepper/tick.pep -p 18000
    ```

    Source code:

    ```pepper
    --8<-- "docs/src/pepper/tick.pep"
    ```

=== "pub.pep"

    Start a publisher instance to publish data to the message broker, publish 10 records every second. `-i 1000` is required to trigger job every 1 second.

    ```bash
    pepper ./src/pepper/pub.pep -i 1000
    ```

    Source code:

    ```pepper
    --8<-- "docs/src/pepper/pub.pep"
    ```

=== "sub.pep"

    Start a subscriber instance to subscribe data from the message broker. Trade and quote tables shall be able to query on subscriber instance.

    ```bash
    pepper ./src/pepper/sub.pep
    ```

    Source code:

    ```pepper
    --8<-- "docs/src/pepper/sub.pep"
    ```
