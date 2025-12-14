# Math

## Functions

### `abs`

Get the absolute value of a number.

| Parameters | Type | Description                        |
| ---------- | ---- | ---------------------------------- |
| value      | any  | Value to get the absolute value of |

### `acos`

Get the arccosine of a number.

| Parameters | Type | Description                   |
| ---------- | ---- | ----------------------------- |
| value      | any  | Value to get the arccosine of |

### `acosh`

Get the hyperbolic arccosine of a number.

| Parameters | Type | Description                              |
| ---------- | ---- | ---------------------------------------- |
| value      | any  | Value to get the hyperbolic arccosine of |

### `all`

Check if all values in a collection are true.

| Parameters | Type       | Description         |
| ---------- | ---------- | ------------------- |
| collection | collection | Collection to check |

### `any`

Check if any value in a collection is true.

| Parameters | Type       | Description         |
| ---------- | ---------- | ------------------- |
| collection | collection | Collection to check |

### `asin`

Get the arcsine of a number.

| Parameters | Type | Description                 |
| ---------- | ---- | --------------------------- |
| value      | any  | Value to get the arcsine of |

### `asinh`

Get the hyperbolic arcsine of a number.

| Parameters | Type | Description                            |
| ---------- | ---- | -------------------------------------- |
| value      | any  | Value to get the hyperbolic arcsine of |

### `atan`

Get the arctangent of a number.

| Parameters | Type | Description                    |
| ---------- | ---- | ------------------------------ |
| value      | any  | Value to get the arctangent of |

### `atanh`

Get the hyperbolic arctangent of a number.

| Parameters | Type | Description                               |
| ---------- | ---- | ----------------------------------------- |
| value      | any  | Value to get the hyperbolic arctangent of |

### `cbrt`

Get the cube root of a number.

| Parameters | Type | Description                   |
| ---------- | ---- | ----------------------------- |
| value      | any  | Value to get the cube root of |

### `ceil`

Get the ceiling of a number.

| Parameters | Type | Description                 |
| ---------- | ---- | --------------------------- |
| value      | any  | Value to get the ceiling of |

### `corr`

Get the correlation between two series.

| Parameters | Type   | Description                    |
| ---------- | ------ | ------------------------------ |
| p1         | series | Series to get correlation from |
| p2         | series | Series to get correlation from |

### `cos`

Get the cosine of a number.

| Parameters | Type | Description                |
| ---------- | ---- | -------------------------- |
| value      | any  | Value to get the cosine of |

### `cosh`

Get the hyperbolic cosine of a number.

| Parameters | Type | Description                           |
| ---------- | ---- | ------------------------------------- |
| value      | any  | Value to get the hyperbolic cosine of |

### `cot`

Get the cotangent of a number.

| Parameters | Type | Description                   |
| ---------- | ---- | ----------------------------- |
| value      | any  | Value to get the cotangent of |

### `cov0`

Get the covariance with 0 degrees of freedom of two series.

| Parameters | Type   | Description                   |
| ---------- | ------ | ----------------------------- |
| p1         | series | Series to get covariance from |
| p2         | series | Series to get covariance from |

### `cov1`

Get the covariance with 1 degrees of freedom of two series.

| Parameters | Type   | Description                   |
| ---------- | ------ | ----------------------------- |
| p1         | series | Series to get covariance from |
| p2         | series | Series to get covariance from |

### `div`

Integer division of two numbers.

| Parameters | Type | Description |
| ---------- | ---- | ----------- |
| p1         | any  | Dividend    |
| p2         | any  | Divisor     |

### `exp`

Get the exponential of a number.

| Parameters | Type | Description                     |
| ---------- | ---- | ------------------------------- |
| value      | any  | Value to get the exponential of |

### `floor`

Get the floor of a number.

| Parameters | Type | Description               |
| ---------- | ---- | ------------------------- |
| value      | any  | Value to get the floor of |

### `kurtosis`

Get the kurtosis of a series.

| Parameters | Type   | Description                 |
| ---------- | ------ | --------------------------- |
| series     | series | Series to get kurtosis from |

### `ln`

Get the natural logarithm of a number.

| Parameters | Type | Description                           |
| ---------- | ---- | ------------------------------------- |
| value      | any  | Value to get the natural logarithm of |

### `log`

Get the logarithm of a number.

| Parameters | Type | Description                   |
| ---------- | ---- | ----------------------------- |
| value      | any  | Value to get the logarithm of |
| base       | any  | Base of the logarithm         |

### `log10`

Get the base 10 logarithm of a number.

| Parameters | Type | Description                           |
| ---------- | ---- | ------------------------------------- |
| value      | any  | Value to get the base 10 logarithm of |

### `log1p`

Get the natural logarithm of 1 plus a number.

| Parameters | Type | Description                                  |
| ---------- | ---- | -------------------------------------------- |
| value      | any  | Value to get the natural logarithm of 1 plus |

### `max`

Get the maximum value of a series.

| Parameters | Type   | Description                      |
| ---------- | ------ | -------------------------------- |
| series     | series | Series to get maximum value from |

### `mean`

Get the mean of a series.

| Parameters | Type   | Description             |
| ---------- | ------ | ----------------------- |
| series     | series | Series to get mean from |

### `median`

Get the median of a series.

| Parameters | Type   | Description               |
| ---------- | ------ | ------------------------- |
| series     | series | Series to get median from |

### `min`

Get the minimum value of a series.

| Parameters | Type   | Description                      |
| ---------- | ------ | -------------------------------- |
| series     | series | Series to get minimum value from |

### `mmax`

Get the moving maximum value of a series.

| Parameters | Type   | Description                       |
| ---------- | ------ | --------------------------------- |
| window     | i64    | Window size                       |
| series     | series | Series to get moving maximum from |

### `mmean`

Get the moving mean of a series.

| Parameters | Type   | Description                    |
| ---------- | ------ | ------------------------------ |
| window     | i64    | Window size                    |
| series     | series | Series to get moving mean from |

### `mmedian`

Get the moving median of a series.

| Parameters | Type   | Description                      |
| ---------- | ------ | -------------------------------- |
| window     | i64    | Window size                      |
| series     | series | Series to get moving median from |

### `mmin`

Get the moving minimum value of a series.

| Parameters | Type   | Description                       |
| ---------- | ------ | --------------------------------- |
| window     | i64    | Window size                       |
| series     | series | Series to get moving minimum from |

### `mod`

Get the modulus of two numbers.

| Parameters | Type | Description |
| ---------- | ---- | ----------- |
| p1         | any  | Dividend    |
| p2         | any  | Divisor     |

### `mode`

Get the mode of a series.

| Parameters | Type   | Description             |
| ---------- | ------ | ----------------------- |
| series     | series | Series to get mode from |

### `mquantile`

Get the moving quantile of a series.

| Parameters | Type   | Description                        |
| ---------- | ------ | ---------------------------------- |
| percentile | f64    | Percentile to get                  |
| size       | i64    | Size of the window                 |
| series     | series | Series to get moving quantile from |

### `mskew`

Get the moving skew of a series.

| Parameters | Type   | Description                    |
| ---------- | ------ | ------------------------------ |
| window     | i64    | Window size                    |
| series     | series | Series to get moving skew from |

### `mstd0`

Get the moving standard deviation with 0 degrees of freedom of a series.

| Parameters | Type   | Description                                  |
| ---------- | ------ | -------------------------------------------- |
| window     | i64    | Window size                                  |
| series     | series | Series to get moving standard deviation from |

### `mstd1`

Get the moving standard deviation with 1 degrees of freedom of a series.

| Parameters | Type   | Description                                  |
| ---------- | ------ | -------------------------------------------- |
| window     | i64    | Window size                                  |
| series     | series | Series to get moving standard deviation from |

### `msum`

Get the moving sum of a series.

| Parameters | Type   | Description                   |
| ---------- | ------ | ----------------------------- |
| window     | i64    | Window size                   |
| series     | series | Series to get moving sum from |

### `mvar0`

Get the moving variance with 0 degrees of freedom of a series.

| Parameters | Type   | Description                        |
| ---------- | ------ | ---------------------------------- |
| window     | i64    | Window size                        |
| series     | series | Series to get moving variance from |

### `mvar1`

Get the moving variance with 1 degrees of freedom of a series.

| Parameters | Type   | Description                        |
| ---------- | ------ | ---------------------------------- |
| window     | i64    | Window size                        |
| series     | series | Series to get moving variance from |

### `neg`

Get the negative of a number.

| Parameters | Type | Description                  |
| ---------- | ---- | ---------------------------- |
| value      | any  | Value to get the negative of |

### `pc`

Get the percentage change of a series.

| Parameters | Type   | Description                          |
| ---------- | ------ | ------------------------------------ |
| series     | series | Series to get percentage change from |

### `pow`

Get the power of a number.

| Parameters | Type | Description           |
| ---------- | ---- | --------------------- |
| base       | any  | Base of the power     |
| exponent   | any  | Exponent of the power |

### `prod`

Get the product of a series.

| Parameters | Type   | Description                |
| ---------- | ------ | -------------------------- |
| series     | series | Series to get product from |

### `quantile`

Get the quantile of a series.

| Parameters | Type   | Description                 |
| ---------- | ------ | --------------------------- |
| percentile | f64    | Percentile to get           |
| series     | series | Series to get quantile from |

### `round`

Get the rounded value of a series.

| Parameters | Type       | Description                          |
| ---------- | ---------- | ------------------------------------ |
| n          | i64        | Number of decimal places to round to |
| collection | collection | Collection to round                  |

### `sign`

Get the sign of a number.

| Parameters | Type | Description              |
| ---------- | ---- | ------------------------ |
| value      | any  | Value to get the sign of |

### `sin`

Get the sine of a number.

| Parameters | Type | Description              |
| ---------- | ---- | ------------------------ |
| value      | any  | Value to get the sine of |

### `sinh`

Get the hyperbolic sine of a number.

| Parameters | Type | Description                         |
| ---------- | ---- | ----------------------------------- |
| value      | any  | Value to get the hyperbolic sine of |

### `skew`

Get the skew of a series.

| Parameters | Type   | Description             |
| ---------- | ------ | ----------------------- |
| series     | series | Series to get skew from |

### `sqrt`

Get the square root of a number.

| Parameters | Type | Description                     |
| ---------- | ---- | ------------------------------- |
| value      | any  | Value to get the square root of |

### `std0`

Get the standard deviation with 0 degrees of freedom of a series.

| Parameters | Type   | Description                           |
| ---------- | ------ | ------------------------------------- |
| series     | series | Series to get standard deviation from |

### `std1`

Get the standard deviation with 1 degrees of freedom of a series.

| Parameters | Type   | Description                           |
| ---------- | ------ | ------------------------------------- |
| series     | series | Series to get standard deviation from |

### `sum`

Get the sum of a series.

| Parameters | Type   | Description            |
| ---------- | ------ | ---------------------- |
| series     | series | Series to get sum from |

### `tan`

Get the tangent of a number.

| Parameters | Type | Description                 |
| ---------- | ---- | --------------------------- |
| value      | any  | Value to get the tangent of |

### `tanh`

Get the hyperbolic tangent of a number.

| Parameters | Type | Description                            |
| ---------- | ---- | -------------------------------------- |
| value      | any  | Value to get the hyperbolic tangent of |

### `var0`

Get the variance with 0 degrees of freedom of a series.

| Parameters | Type   | Description                 |
| ---------- | ------ | --------------------------- |
| series     | series | Series to get variance from |

### `var1`

Get the variance with 1 degrees of freedom of a series.

| Parameters | Type   | Description                 |
| ---------- | ------ | --------------------------- |
| series     | series | Series to get variance from |

### `wmean`

Get the weighted mean of a series.

| Parameters | Type   | Description                       |
| ---------- | ------ | --------------------------------- |
| weights    | series | Weights to get weighted mean from |
| series     | series | Series to get weighted mean from  |

### `wsum`

Get the weighted sum of a series.

| Parameters | Type   | Description                      |
| ---------- | ------ | -------------------------------- |
| weights    | series | Weights to get weighted sum from |
| series     | series | Series to get weighted sum from  |
