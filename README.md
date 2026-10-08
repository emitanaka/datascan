

<!-- README.md is generated from README.qmd. Please edit that file -->

# datascan

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/datascan)](https://CRAN.R-project.org/package=datascan)
<!-- badges: end -->

The goal of datascan is to provide a set of functions to perform data
quality checks and data exploration in R. It includes functions for
checking missing values, identifying nested columns, and other common
data quality issues.

## Installation

You can install the released version of datascan from
[CRAN](https://CRAN.R-project.org/package=datascan) with:

``` r
install.packages("datascan")
```

You can install the development version of datascan from
[GitHub](https://github.com/emitanaka/datascan) with:

``` r
# install.packages("pak")
pak::pak("emitanaka/datascan")
```

## Overview

`datascan` helps you get to know the structure of a new data set before
you analyse it.

``` r
library(datascan)
```

## Scan all columns at once

`cols_identify_all()` runs several checks together: columns where every
value is unique, pairs of columns that are one-to-one, constant columns,
and columns that are entirely missing.

``` r
survey <- data.frame(
  id = 1:6,
  site = c("Melbourne", "Melbourne", "Sydney", "Sydney", "Perth", "Perth"),
  site_code = c("MEL", "MEL", "SYD", "SYD", "PER", "PER"),
  rainfall = c(30, 42, NA, 61, 12, NA),
  notes = NA
)
cols_identify_all(survey)
#> 
#> ── Checking if all values are unique in a column ───────────────────────────────
#> [1] "id"
#> 
#> ── Checking if any two columns are bijective ───────────────────────────────────
#> [[1]]
#> [1] "site"      "site_code"
#> 
#> ── Checking if any column is all constant ──────────────────────────────────────
#> [1] "notes"
#> 
#> ── Checking if columns with preset cut-off in missing values ───────────────────
#> [1] "notes"
```

Here `id` is a row identifier, `site` and `site_code` carry the same
information, and `notes` is empty.

## Find columns with particular values

Each check returns the names of the matching columns, so the result can
be used directly to select or drop columns.

``` r
# columns with exactly two values
cols_binary(mtcars)
#> [1] "vs" "am"

# columns with exactly three values
cols_ternary(mtcars)
#> [1] "cyl"  "gear"

# columns with a single value
cols_constant(data.frame(x = 1:3, unit = "kg", site = c("A", "B", "C")))
#> [1] "unit"
```

Two columns are bijective when there is a one-to-one match between their
values, for example a site name and a site code. One of them is usually
redundant.

``` r
sites <- data.frame(
  site = c("Melbourne", "Melbourne", "Sydney", "Sydney", "Perth"),
  code = c("MEL", "MEL", "SYD", "SYD", "PER"),
  rainfall = c(30, 42, 55, 61, 12)
)
cols_bijective(sites)
#> [[1]]
#> [1] "site" "code"
```

## Find missing values

`cols_missing()` and `rows_missing()` find the columns or rows where the
proportion of missing values is at least `cutoff`. The default cutoff of
1 finds columns or rows that are entirely missing.

``` r
# columns with at least 1% missing
cols_missing(airquality, cutoff = 0.01)
#> [1] "Ozone"   "Solar.R"

# columns with at least 20% missing
cols_missing(airquality, cutoff = 0.2)
#> [1] "Ozone"

# rows with at least 30% missing
rows_missing(airquality, cutoff = 0.3)
#> [1]  5 27
```

## Find the observational unit

The observational unit is the entity that each row measures. In
`ChickWeight`, each row is the weight of one chick at one time point, so
`Chick` and `Time` together identify each row. Adding `Diet` makes no
difference, because each chick is given only one diet, so `Diet` is
redundant.

``` r
is_obs_unit(ChickWeight, Chick, Time)
is_obs_unit(ChickWeight, Chick, Time, Diet)
#> ✖ `Diet` is redundant.
```

In the `white_clover` experiment, each plant is identified by its
garden, whole plot, split plot and position in the split plot.

``` r
is_obs_unit(white_clover, Garden, WholePlotID, SplitPlotID, PlantID)
```

## Check nested and crossed structures

A variable is nested within another if each of its levels appears in
only one level of the other. `cols_nested()` checks every pair of
columns. In `CO2`, each plant comes from one place (`Type`) and was
given one treatment.

``` r
cols_nested(CO2)
#> [[1]]
#> [1] "Plant" "Type" 
#> 
#> [[2]]
#> [1] "Plant"     "Treatment"
```

Nesting checks can also catch implicit nesting, where the same labels
are reused in different groups. In `white_clover`, the whole plots are
numbered 1 to 48 in *both* gardens, so `WholePlotID` on its own is not
nested within `Garden`. Combining the two gives a unique whole plot
identifier that is.

``` r
is_nested(white_clover$WholePlotID, white_clover$Garden)
#> [1] FALSE

whole_plot <- interaction(white_clover$Garden, white_clover$WholePlotID)
is_nested(whole_plot, white_clover$Garden)
#> [1] TRUE
```

`cols_nested()` is also a quick way to see which variables are measured
at which level. In `watch_tits`, each row is one bird (`carer_id`)
during one feeding watch (`id`) at a nest. Each pair in the output is a
child variable followed by the variable it is nested within. Watches are
nested within nests, and nests within years. `brood_size` is recorded
once per nest and `watch_time` once per watch, while `feeds` varies from
bird to bird.

``` r
tits <- watch_tits[c(
  "id",
  "carer_id",
  "nest",
  "year",
  "brood_size",
  "watch_time",
  "feeds"
)]
cols_nested(tits)
#> [[1]]
#> [1] "id"   "nest"
#> 
#> [[2]]
#> [1] "id"   "year"
#> 
#> [[3]]
#> [1] "id"         "brood_size"
#> 
#> [[4]]
#> [1] "id"         "watch_time"
#> 
#> [[5]]
#> [1] "nest" "year"
#> 
#> [[6]]
#> [1] "nest"       "brood_size"
```

By default, trivial cases of nesting are ignored: a constant column, a
column with all unique values, or two bijective columns. Use `ignore` to
choose which of these to leave out. Here, `site` and `site_code` are
nested within each other only because they are bijective:

``` r
cols_nested(sites)
#> list()
cols_nested(sites, ignore = c("constant", "unique"))
#> [[1]]
#> [1] "site" "code"
#> 
#> [[2]]
#> [1] "code" "site"
```

`is_complete()` checks the opposite situation: whether every level of
one variable appears at every level of another, as in a fully crossed
design.

``` r
is_complete(CO2$conc, CO2$Plant)
#> [1] TRUE
```

## Count shared levels across groups

`concurrence_matrix()` counts how many levels of one variable are shared
between each pair of levels of another. For example, how many of the
same birds were seen feeding in each pair of years. Some rows have no
`carer_id`, so `na.rm = TRUE` drops them rather than counting the
missing value as one more bird:

``` r
carers <- concurrence_matrix(watch_tits, carer_id, year, na.rm = TRUE)
carers
#> • Diagonal shows the total number of levels for carer_id at the corresponding
#>   level for year
#> • Off-diagonal shows the number of common levels for carer_id between the two
#>   levels for year
#>       
#>        1994 1995 1996 1997 1998 1999 2000 2001 2002 2003
#>   1994   24   12    2    2    2    1    0    0    1    1
#>   1995   12   32    8    2    5    1    0    0    1    1
#>   1996    2    8   23    3    4    1    0    0    0    0
#>   1997    2    2    3   17    2    1    0    0    0    0
#>   1998    2    5    4    2   18    3    0    1    2    1
#>   1999    1    1    1    1    3   28    7    5    2    2
#>   2000    0    0    0    0    0    7   35    6    3    2
#>   2001    0    0    0    0    1    5    6   23    7    4
#>   2002    1    1    0    0    2    2    3    7   24    4
#>   2003    1    1    0    0    1    2    2    4    4   36
#>   ...
#> ℹ Concurrence matrix: 24 × 24 year. Showing only 10 × 10. Use `print(x, n =
#>   ...)` to show more.
```

The diagonal shows the number of birds seen in each year, and the
off-diagonal shows the number seen in both years. Use `extract()` to
look at particular years, or `proportions()` to get the proportion of
each year’s birds that were also seen in another year:

``` r
extract(carers, c("2017", "2018", "2019"), c("2017", "2018", "2019"))
#>       
#>        2017 2018 2019
#>   2017   22    5    3
#>   2018    5   40   11
#>   2019    3   11   52
proportions(carers, 1) |>
  extract(c("2017", "2018", "2019"), c("2017", "2018", "2019"))
#>       
#>              2017      2018      2019
#>   2017 0.55000000 0.1250000 0.0750000
#>   2018 0.07246377 0.5797101 0.1594203
#>   2019 0.03846154 0.1410256 0.6666667
```

`concurrence_table()` gives the same information in long format, which
is easier to filter or plot.

``` r
concurrence_table(watch_tits, carer_id, year, na.rm = TRUE)
#> # A tibble:  576 × 5
#> # Dimension: 24 × 24 year
#>    year_1 year_2 concurrence prop_in_1 prop_in_2
#>    <fct>  <fct>        <dbl>     <dbl>     <dbl>
#>  1 1994   1994            24    1         1     
#>  2 1994   1995            12    0.5       0.375 
#>  3 1994   1996             2    0.0833    0.0870
#>  4 1994   1997             2    0.0833    0.118 
#>  5 1994   1998             2    0.0833    0.111 
#>  6 1994   1999             1    0.0417    0.0357
#>  7 1994   2000             0    0         0     
#>  8 1994   2001             0    0         0     
#>  9 1994   2002             1    0.0417    0.0417
#> 10 1994   2003             1    0.0417    0.0278
#> # ℹ 566 more rows
```

## Check numerical data

Numbers are often read in as text because of a few entries such as
`"<1"` or `"n/a"`. `is_numerical()` and `as_numerical()` report which
entries cannot be converted to numbers.

``` r
x <- c("12", "7.5", "<1", "3", "n/a")
is_numerical(x)
#> ✖ Non-numerical entries found: <1, n/a
#> [1] FALSE
as_numerical(x)
#> ✖ Non-numerical entries found: <1, n/a
#> [1] 12.0  7.5   NA  3.0   NA
```
