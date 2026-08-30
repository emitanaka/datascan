# Identify rows that have certain proportion of missing values

Similar to janitor::remove_empty, except this function aims to identify
the columns without removing them. If there are no identified columns,
it will return NA.

## Usage

``` r
rows_missing(data, cutoff = 1)
```

## Arguments

- data:

  The data frame

- cutoff:

  The minimum cutoff for the proportion of missing values.

## Value

An integer vector of rows with missing values with at least a certain
proportion.

## Examples

``` r
rows_missing(airquality, 0.1)
#>  [1]   5   6  10  11  25  26  27  32  33  34  35  36  37  39  42  43  45  46  52
#> [20]  53  54  55  56  57  58  59  60  61  65  72  75  83  84  96  97  98 102 103
#> [39] 107 115 119 150
```
