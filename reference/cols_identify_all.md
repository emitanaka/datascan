# Identify all columns with potential issues

This function identifies all columns with potential issues, including
all unique values, bijective columns, constant columns, and columns with
missing values above a certain cutoff. It returns a list of identified
columns for each category and can print the results to the console.

## Usage

``` r
cols_identify_all(data, cutoff = 1, na.rm = FALSE, print = TRUE)
```

## Arguments

- data:

  The data frame

- cutoff:

  The minimum cutoff for the proportion of missing values.

- na.rm:

  Should missing values be removed?

- print:

  Print the output or not.

## Value

A list for each issue.

## See also

Other quality checks:
[`cols_all_unique()`](http://emitanaka.org/datascan/reference/cols_all_unique.md),
[`cols_bijective()`](http://emitanaka.org/datascan/reference/cols_bijective.md),
[`cols_constant()`](http://emitanaka.org/datascan/reference/cols_constant.md),
[`cols_missing()`](http://emitanaka.org/datascan/reference/cols_missing.md),
[`cols_nested()`](http://emitanaka.org/datascan/reference/cols_nested.md)

## Examples

``` r
cols_identify_all(airquality)
#> → No columns with all unique values.
#> → No bijective columns.
#> → No constant columns.
#> → No identified columns with missing proportion.
#> 
#> ── Checking if all values are unique in a column ───────────────────────────────
#> [1] NA
#> 
#> ── Checking if any two columns are bijective ───────────────────────────────────
#> list()
#> 
#> ── Checking if any column is all constant ──────────────────────────────────────
#> [1] NA
#> 
#> ── Checking if columns with preset cut-off in missing values ───────────────────
#> [1] NA
```
