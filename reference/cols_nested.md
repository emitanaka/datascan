# Nestedness checks

This function checks for nestedness in a data frame. It identifies
columns that are nested within other columns, meaning that the values in
one column are subsets of the values in another column. The function
returns a list of identified nested columns and can print the results to
the console.

## Usage

``` r
cols_nested(data, na.rm = FALSE)
```

## Arguments

- data:

  The data frame to be checked for nestedness.

- na.rm:

  Remove NA values when checking for nestedness.

## Value

A list of identified nested columns. The first element of each list is
the child variable, and the second element is the parent variable.

## See also

Other quality checks:
[`cols_all_unique()`](http://emitanaka.org/datascan/reference/cols_all_unique.md),
[`cols_bijective()`](http://emitanaka.org/datascan/reference/cols_bijective.md),
[`cols_constant()`](http://emitanaka.org/datascan/reference/cols_constant.md),
[`cols_identify_all()`](http://emitanaka.org/datascan/reference/cols_identify_all.md),
[`cols_missing()`](http://emitanaka.org/datascan/reference/cols_missing.md)

## Examples

``` r
df <- data.frame(
  A = c("x", "y", "z"),
  B = c("x", "y", "z", "w"),
  C = c("x", "y", "z")
)
#> Error in data.frame(A = c("x", "y", "z"), B = c("x", "y", "z", "w"), C = c("x",     "y", "z")): arguments imply differing number of rows: 3, 4
cols_nested(df)
#> list()
```
