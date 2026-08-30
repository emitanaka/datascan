# Identify columns with a specific number of unique values

This function identifies columns in a data frame that have a specific
number of unique values. It can be used to find constant, binary,
ternary, or any other n-ary columns. If there are no identified columns,
it will return NA.

## Usage

``` r
cols_binary(data, na.rm = FALSE)

cols_ternary(data, na.rm = FALSE)

cols_multinary(data, na.rm = FALSE, n = 1)
```

## Arguments

- data:

  The data frame

- na.rm:

  Logical, whether to remove NA values before counting unique values.

- n:

  The specific number of unique values to look for.

## Value

A character vector of column names that have exactly n unique values.

## Examples

``` r
cols_binary(mtcars)
#> [1] "vs" "am"
```
