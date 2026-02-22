# Partitioned DataFrame

- no sym file, no attributes
- allow to load multiple partitioned dataframe paths
- `par` function to access shadowed partitioned dataframe

## Structure

```bash
data/hdb
├── table1 # partitioned by date
│   ├── schema # empty data
│   ├── 2000.01.01_0000
│   ├── 2000.01.01_0001
│   └── 2000.01.02_0000
├── table2 # partitioned by year
│   ├── schema # empty data
│   └── 2000_0000
└── table3 # single file(just one parquet file)
```

schema file is empty data, it is used to validate the schema of the data.

## Write Partitioned DataFrame

=== "chili"

    ```chili
    // partition by date
    trade: ([]sym:100?`a`b`c, time: 100#now(`Asia/Tokyo), qty: 100?100, price: 100?100.0);
    wpar(`/tmp/hdb, today(`), `trade, trade, `time, 0b);

    // partition by year
    order: ([]sym:100?`a`b`c, time: 100#now(`Asia/Tokyo), order_id: range(100), qty: 100?100, price: 100?100.0);
    wpar(`/tmp/hdb, 2025, `order, order, `time, 0b);

    // single file
    ex2tz: ([]exchange: `TSE`HKG, tz: `Asia/Tokyo`Asia/Hong_Kong);
    wpar(`/tmp/hdb, 0n, `ex2tz, ex2tz, `time, 0b);
    ```

=== "pepper"

    ```pepper
    // partition by date
    trade: ([]sym:100?`a`b`c; time: 100#now`Asia/Tokyo; qty: 100?100; price: 100?100.0);
    wpar[`/tmp/hdb; today`; `trade; trade; `time; 0b];

    // partition by year
    order: ([]sym:100?`a`b`c; time: 100#now`Asia/Tokyo; order_id: range 100;qty: 100?100; price: 100?100.0);
    wpar[`/tmp/hdb; 2025; `order; order; `time; 0b];

    // single file
    ex2tz: ([]exchange: `TSE`HKG; tz: `Asia/Tokyo`Asia/Hong_Kong);
    wpar[`/tmp/hdb; 0n; `ex2tz; ex2tz; `time; 0b];
    ```

## Read Partitioned DataFrame

It is possible to load multiple partitioned dataframe paths at once. However, there is duplicate table names in different paths, the last loaded table will be used.

=== "chili"

    ```chili

    load("/tmp/hdb");

    trade
    ([] `par_df trade, ByDate)

    order
    ([] `par_df order, ByYear)

    ex2tz
    ([] `par_df ex2tz, Single)

    select from ex2tz;

    select from order where year=2025;

    // when query date doesn't exist, it will return a empty dataframe from the latest partition
    select from trade where date=today(`);

    ```

=== "pepper"

    ```pepper
    load "/tmp/hdb";

    trade
    ([] `par_df trade, ByDate)

    order
    ([] `par_df order, ByYear)

    ex2tz
    ([] `par_df ex2tz, Single)

    select from ex2tz;

    select from order where year=2025;

    // when query date doesn't exist, it will return a empty dataframe from the latest partition
    select from trade where date=today[`];
    ```
