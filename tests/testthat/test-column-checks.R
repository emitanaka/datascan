test_that("check works", {
  expect_true(is_obs_unit(ChickWeight, Time, Chick))
  expect_false(is_obs_unit(ChickWeight, Time, Chick, Diet))
  n <- 10
  df <- data.frame(
    x0 = NA,
    x1 = 1,
    x2 = rep(1:2, length.out = n),
    x3 = rep(1:3, length.out = n),
    x4 = rep(1:4, length.out = n)
  )
  expect_equal(
    cols_constant(df, na.rm = TRUE),
    "x1"
  )
  expect_equal(
    cols_binary(df, na.rm = TRUE),
    "x2"
  )
  expect_equal(
    cols_ternary(df, na.rm = TRUE),
    "x3"
  )
  expect_equal(
    cols_multinary(df, na.rm = TRUE, n = 4),
    "x4"
  )
})

test_that("missing checks use the cutoff", {
  df <- data.frame(
    none = 1:4,
    some = c(1, NA, 3, 4),
    half = c(NA, NA, 3, 4),
    all = NA
  )
  expect_equal(cols_missing(df), "all")
  expect_equal(cols_missing(df, 0), c("some", "half", "all"))
  expect_equal(cols_missing(df, 0.5), c("half", "all"))
  expect_equal(rows_missing(df), NA)
  expect_equal(rows_missing(df, 0), 1:4)
  expect_equal(rows_missing(df, 0.5), 1:2)
  expect_equal(rows_missing(df, 0.75), 2L)
})

test_that("cols_bijective ignores constant and all unique columns", {
  df <- data.frame(
    id = 1:4,
    unit = "kg",
    notes = NA,
    site = c("A", "A", "B", "B"),
    code = c("a", "a", "b", "b")
  )
  expect_equal(cols_bijective(df), list(c("site", "code")))
})
