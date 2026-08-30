# Identify constant columns

Similar to janitor::remove_constant, except this function aims to
identify the constant columns without removing them. If there are no
constant columns, it will return NA.

## Usage

``` r
cols_constant(data, na.rm = FALSE)

cols_unary(data, na.rm = FALSE)
```

## Arguments

- data:

  The data frame

- na.rm:

  Should missing values be removed?

## Value

A character vector of constant columns.

## See also

Other quality checks:
[`cols_all_unique()`](http://emitanaka.org/datascan/reference/cols_all_unique.md),
[`cols_bijective()`](http://emitanaka.org/datascan/reference/cols_bijective.md),
[`cols_identify_all()`](http://emitanaka.org/datascan/reference/cols_identify_all.md),
[`cols_missing()`](http://emitanaka.org/datascan/reference/cols_missing.md),
[`cols_nested()`](http://emitanaka.org/datascan/reference/cols_nested.md)

## Examples

``` r
df <- data.frame(x1 = 1, x2 = c("A", "B", "C"), x3 = "a")
cols_constant(df)
#> [1] "x1" "x3"
```
