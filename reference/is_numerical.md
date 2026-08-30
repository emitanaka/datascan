# Is the variable numerical?

This function checks if a variable is numerical. It returns TRUE if the
variable is numerical and FALSE otherwise. If non-numerical entries are
found, it prints a message indicating the non-numerical entries.

## Usage

``` r
is_numerical(x)
```

## Arguments

- x:

  A vector to be checked for numericality.

## Value

TRUE if the variable is numerical, FALSE otherwise.

## See also

Other numerical:
[`as_numerical()`](http://emitanaka.org/datascan/reference/as_numerical.md)

## Examples

``` r
is_numerical(c("1", "2", "3"))
#> [1] TRUE
is_numerical(c("1", "2", "3", "A"))
#> ✖ Non-numerical entries found: A
#> [1] FALSE
```
