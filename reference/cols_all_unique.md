# Identify columns with all unique values

Find columns that have all unique values. If there are no identified
columns, it will return NA.

## Usage

``` r
cols_all_unique(data)
```

## Arguments

- data:

  The data frame

## Value

A character vector of column names with all unique values.

## See also

Other quality checks:
[`cols_bijective()`](http://emitanaka.org/datascan/reference/cols_bijective.md),
[`cols_constant()`](http://emitanaka.org/datascan/reference/cols_constant.md),
[`cols_identify_all()`](http://emitanaka.org/datascan/reference/cols_identify_all.md),
[`cols_missing()`](http://emitanaka.org/datascan/reference/cols_missing.md),
[`cols_nested()`](http://emitanaka.org/datascan/reference/cols_nested.md)

## Examples

``` r
cols_all_unique(ChickWeight)
#> → No columns with all unique values.
#> [1] NA
```
