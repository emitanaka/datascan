# Add a row ID column to a data frame

This function adds a new column to a data frame containing a unique
identifier for each row. The default column name is ".id", but this can
be customized using the `name` parameter.

## Usage

``` r
add_row_id(data, name = ".id")
```

## Arguments

- data:

  A data frame to which the row ID column will be added.

- name:

  The name of the new row ID column. Default is ".id".

## Value

The input data frame with an additional column containing row IDs.

## Examples

``` r
df <- data.frame(x = c(1, 2, 3), y = c("a", "b", "c"))
add_row_id(df)
#>   x y .id
#> 1 1 a   1
#> 2 2 b   2
#> 3 3 c   3
```
