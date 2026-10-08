# Changelog

## datascan (development version)

- [`cols_missing()`](http://emitanaka.org/datascan/reference/cols_missing.md)
  and
  [`rows_missing()`](http://emitanaka.org/datascan/reference/rows_missing.md)
  with `cutoff = 0` now return only the columns or rows that have at
  least one missing value, instead of all of them.
- [`concurrence_matrix()`](http://emitanaka.org/datascan/reference/concurrence_matrix.md)
  and
  [`concurrence_table()`](http://emitanaka.org/datascan/reference/concurrence_matrix.md)
  now treat `NA` as a level when `na.rm = FALSE`, instead of silently
  dropping it. As a result,
  [`is_nested()`](http://emitanaka.org/datascan/reference/is_nested.md),
  [`is_complete()`](http://emitanaka.org/datascan/reference/is_complete.md)
  and
  [`cols_nested()`](http://emitanaka.org/datascan/reference/cols_nested.md)
  with `na.rm = FALSE` now take missing values into account.
- [`concurrence_table()`](http://emitanaka.org/datascan/reference/concurrence_matrix.md)
  now shows the name of the grouping variable in its header, instead of
  always saying “environments”.
- [`cols_bijective()`](http://emitanaka.org/datascan/reference/cols_bijective.md)
  no longer reports constant columns as bijective with each other.
- tidyr is no longer a dependency.

## datascan 0.1.1

CRAN release: 2026-10-06

- Initial CRAN release.
