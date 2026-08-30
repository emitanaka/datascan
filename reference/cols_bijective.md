# Identify bijective (one-to-one correspondence) columns

Any values that have all unique values will not be included in the
output. If there are no identified columns, it will return an emtpy
list.

## Usage

``` r
cols_bijective(data)
```

## Arguments

- data:

  The data frame

## Value

A list of character vectors of bijective columns.

## See also

Other quality checks:
[`cols_all_unique()`](http://emitanaka.org/datascan/reference/cols_all_unique.md),
[`cols_constant()`](http://emitanaka.org/datascan/reference/cols_constant.md),
[`cols_identify_all()`](http://emitanaka.org/datascan/reference/cols_identify_all.md),
[`cols_missing()`](http://emitanaka.org/datascan/reference/cols_missing.md),
[`cols_nested()`](http://emitanaka.org/datascan/reference/cols_nested.md)

## Examples

``` r
cols_bijective(OrchardSprays)
#> → No bijective columns.
#> list()
```
