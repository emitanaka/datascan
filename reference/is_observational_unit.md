# Is it the observational unit?

An observational unit is the entity that is being measured in a study.
For example, if blood pressure of a person is measured, then the person
is the observational unit. If blood pressure is measured multiple times
for a person, then the observational unit is the person and the time of
measurement.

## Usage

``` r
is_observational_unit(.data, ..., .check_redundancy = TRUE)

is_obs_unit(.data, ..., .check_redundancy = TRUE)
```

## Arguments

- .data:

  The data frame

- ...:

  The columns in the data frame that potentially index the observational
  unit.

- .check_redundancy:

  Logical. If TRUE, checks if any of the columns are redundant.

## Value

A logical value.

## Details

Supply the columns that potentially index the observational unit. The
column cannot uniquely identify the row. If the number of rows in the
data frame is equal to the number of distinct rows in the selected
columns, then it returns TRUE, otherwise FALSE. If TRUE, it checks if
any of the columns are redundant.

## Examples

``` r
is_observational_unit(ChickWeight, Time, Chick)
is_observational_unit(ChickWeight, Time, Chick, Diet)
#> ✖ `Diet` is redundant.
```
