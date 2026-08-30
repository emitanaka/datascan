# Is variable complete within another variable?

This function checks if a variable is complete within another variable.
If all levels of the first variable appear in all levels of the second
variable, it returns TRUE; otherwise, it returns FALSE. The function can
also handle NA values based on the `na.rm` parameter.

## Usage

``` r
is_complete(x, y, na.rm = TRUE)
```

## Arguments

- x, y:

  Vectors of the same size where `x` (child variable) is checked for
  completeness within `y` (parent variable)

- na.rm:

  Remove NA values when checking for completeness.

## Value

TRUE if the values in vector x are complete

## Examples

``` r
df <- data.frame(
  site = c("A", "A", "B", "B"),
  plot1 = c("A1", "A2", "B1", "B2"),
  plot2 = c("A1", "A2", "A1", "A2")
)
is_complete(df$plot1, df$site) # FALSE
#> [1] FALSE
is_complete(df$plot2, df$site) # TRUE
#> [1] TRUE
```
