# Is variable nested within another variable?

This function checks if a variable is nested within another variable. If
the levels in the first variable appear only within the levels of the
second variable, it returns TRUE; otherwise, it returns FALSE. The
function can also handle NA values based on the `na.rm` parameter.

## Usage

``` r
is_nested(x, y, na.rm = TRUE, ignore = c("constant", "unique", "bijective"))
```

## Arguments

- x, y:

  Vectors of the same size where `x` (child variable) is nested in `y`
  (parent variable)

- na.rm:

  Remove NA values when checking for nestedness.

- ignore:

  A character vector of trivial cases of nesting to ignore, i.e. not
  count as nested. Any of `"constant"` (`x` or `y` has a single value),
  `"unique"` (`x` has all unique values) and `"bijective"` (`x` and `y`
  have a one-to-one correspondence). Use `NULL` to count all cases.

## Value

TRUE if the values in vector x are nested within vector y, FALSE
otherwise. It is also FALSE for any trivial case listed in `ignore`.

## Details

By default, trivial cases of nesting are not counted and it returns
FALSE when `x` or `y` is constant (has a single value), `x` has all
unique values, or `x` and `y` are bijective (have a one-to-one
correspondence). Use `ignore` to choose which of these cases are not
counted.

## Examples

``` r
df <- data.frame(
  site = rep(c("A", "B"), each = 4),
  plot1 = rep(c("A1", "A2", "B1", "B2"), each = 2),
  plot2 = rep(c("A1", "A2", "A1", "A2"), each = 2)
)
is_nested(df$plot1, df$site) # TRUE
#> [1] TRUE
is_nested(df$plot2, df$site) # FALSE since A1 and A2 appear in both sites
#> [1] FALSE
df$id <- seq_len(nrow(df))
is_nested(df$id, df$site) # FALSE since id has all unique values
#> [1] FALSE
is_nested(df$id, df$site, ignore = c("constant", "bijective")) # TRUE
#> [1] TRUE
```
