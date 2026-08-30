

<!-- README.md is generated from README.Rmd. Please edit that file -->

# datascan

<!-- badges: start -->

<!-- badges: end -->

The goal of datascan is to provide a set of functions to perform data
quality checks and data exploration in R. It includes functions for
checking missing values, identifying nested columns, and other common
data quality issues.

## Installation

You can install the development version of datascan from
[GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("emitanaka/datascan")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(datascan)
head(CO2)
#>   Plant   Type  Treatment conc uptake
#> 1   Qn1 Quebec nonchilled   95   16.0
#> 2   Qn1 Quebec nonchilled  175   30.4
#> 3   Qn1 Quebec nonchilled  250   34.8
#> 4   Qn1 Quebec nonchilled  350   37.2
#> 5   Qn1 Quebec nonchilled  500   35.3
#> 6   Qn1 Quebec nonchilled  675   39.2
cols_identify_all(CO2)
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
cols_nested(CO2)
#> [[1]]
#> [1] "Plant" "Type" 
#> 
#> [[2]]
#> [1] "Plant"     "Treatment"
concurrence_matrix(CO2, Plant, Type)
#> • Diagonal shows the total number of levels for Plant at the corresponding
#>   level for Type
#> • Off-diagonal shows the number of common levels for Plant between the two
#>   levels for Type
#>              
#>               Quebec Mississippi
#>   Quebec           6           0
#>   Mississippi      0           6
#>   
#> ℹ Concurrence matrix: 2 × 2 Type.
```
