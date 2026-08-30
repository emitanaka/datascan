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
