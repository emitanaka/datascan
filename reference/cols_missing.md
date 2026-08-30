# Identify columns that have certain proportion of missing values

Similar to janitor::remove_empty, except this function aims to identify
the columns without removing them. If there are no identified columns,
it will return NA.

## Usage

``` r
cols_missing(data, cutoff = 1)
```

## Arguments

- data:

  The data frame

- cutoff:

  The minimum cutoff for the proportion of missing values.

## Value

A character vector of column names with missing values with at least a
certain proportion.

## See also

Other quality checks:
[`cols_all_unique()`](http://emitanaka.org/datascan/reference/cols_all_unique.md),
[`cols_bijective()`](http://emitanaka.org/datascan/reference/cols_bijective.md),
[`cols_constant()`](http://emitanaka.org/datascan/reference/cols_constant.md),
[`cols_identify_all()`](http://emitanaka.org/datascan/reference/cols_identify_all.md),
[`cols_nested()`](http://emitanaka.org/datascan/reference/cols_nested.md)

## Examples

``` r
# find columns that have any missing values
cols_missing(airquality, 0)
#> [1] "Ozone"   "Solar.R" "Wind"    "Temp"    "Month"   "Day"    
```
