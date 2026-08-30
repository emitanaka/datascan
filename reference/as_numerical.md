# Coerce to numerical and identify non-numerical entries

This function attempts to coerce a variable to numerical and identifies
any non-numerical entries. It returns the coerced numerical vector and
prints a message indicating any non-numerical entries found.

## Usage

``` r
as_numerical(x)
```

## Arguments

- x:

  A vector to be coerced to numerical.

## Value

A numerical vector with non-numerical entries coerced to NA.

## See also

Other numerical:
[`is_numerical()`](http://emitanaka.org/datascan/reference/is_numerical.md)

## Examples

``` r
as_numerical(c("1", "2", "A", "4", "B"))
#> ✖ Non-numerical entries found: A, B
#> [1]  1  2 NA  4 NA
```
