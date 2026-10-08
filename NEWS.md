# datascan (development version)

* `cols_missing()` and `rows_missing()` with `cutoff = 0` now return only the
  columns or rows that have at least one missing value, instead of all of them.
* `concurrence_matrix()` and `concurrence_table()` now treat `NA` as a level
  when `na.rm = FALSE`, instead of silently dropping it. As a result,
  `is_nested()`, `is_complete()` and `cols_nested()` with `na.rm = FALSE` now
  take missing values into account.
* `concurrence_table()` now shows the name of the grouping variable in its
  header, instead of always saying "environments".
* `cols_bijective()` no longer reports constant columns as bijective with each
  other.
* tidyr is no longer a dependency.

# datascan 0.1.1

* Initial CRAN release.
