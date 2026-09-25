# Nestedness checks

This function checks for nestedness in a data frame. It identifies
columns that are nested within other columns, meaning that the values in
one column are subsets of the values in another column. The function
returns a list of identified nested columns and can print the results to
the console.

## Usage

``` r
cols_nested(data, na.rm = FALSE, ignore = c("constant", "unique", "bijective"))
```

## Arguments

- data:

  The data frame to be checked for nestedness.

- na.rm:

  Remove NA values when checking for nestedness.

- ignore:

  A character vector of trivial cases of nesting to ignore, i.e. not
  count as nested. Any of `"constant"` (`x` or `y` has a single value),
  `"unique"` (`x` has all unique values) and `"bijective"` (`x` and `y`
  have a one-to-one correspondence). Use `NULL` to count all cases.

## Value

A list of identified nested columns. The first element of each list is
the child variable, and the second element is the parent variable.

## Details

By default, trivial cases of nesting (constant columns, columns with all
unique values and pairs of bijective columns) are not reported as
nested. Use `ignore` to change this (see
[`is_nested()`](http://emitanaka.org/datascan/reference/is_nested.md)).

## See also

Other quality checks:
[`cols_all_unique()`](http://emitanaka.org/datascan/reference/cols_all_unique.md),
[`cols_bijective()`](http://emitanaka.org/datascan/reference/cols_bijective.md),
[`cols_constant()`](http://emitanaka.org/datascan/reference/cols_constant.md),
[`cols_identify_all()`](http://emitanaka.org/datascan/reference/cols_identify_all.md),
[`cols_missing()`](http://emitanaka.org/datascan/reference/cols_missing.md)

## Examples

``` r
cols_nested(CO2)
#> [[1]]
#> [1] "Plant" "Type" 
#> 
#> [[2]]
#> [1] "Plant"     "Treatment"
#> 
```
