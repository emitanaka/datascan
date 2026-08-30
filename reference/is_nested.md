# Is variable nested within another variable?

This function checks if a variable is nested within another variable. If
the levels in the first variable appear only within the levels of the
second variable, it returns TRUE; otherwise, it returns FALSE. The
function can also handle NA values based on the `na.rm` parameter.

## Usage

``` r
is_nested(x, y, na.rm = TRUE)
```

## Arguments

- x, y:

  Vectors of the same size where `x` (child variable) is nested in `y`
  (parent variable)

- na.rm:

  Remove NA values when checking for nestedness.

## Value

TRUE if the values in vector x are nested within vector y, FALSE
otherwise

## Examples

``` r
df <- data.frame(
  site = c("A", "A", "B", "B"),
  plot1 = c("A1", "A2", "B1", "B2"),
  plot2 = c("A1", "A2", "A1", "A2")
)
is_nested(df$plot1, df$site) # TRUE
#> [1] TRUE
is_nested(df$plot2, df$site) # FALSE since A1 and A2 appear in both sites
#> [1] FALSE
```
