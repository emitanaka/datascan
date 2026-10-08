test_that("concurrence works", {
  df <- expand.grid(var = c("A", "B", "C"), grp = paste0("A", 1:20))
  expect_true(all(as.vector(concurrence_matrix(df, var, grp)) == 3))
  expect_equal(
    concurrence_table(df, var, grp),
    data.frame(
      grp_1 = factor(rep(paste0("A", 1:20), each = 20)),
      grp_2 = factor(rep(paste0("A", 1:20), times = 20)),
      concurrence = 3,
      prop_in_1 = 1,
      prop_in_2 = 1
    ),
    ignore_attr = TRUE
  )
})

test_that("concurrence treats NA as a level unless na.rm = TRUE", {
  df <- data.frame(g = c("a", "a", "b", NA), x = c(1, 2, 2, 3))

  mat <- concurrence_matrix(df, x, g)
  expect_equal(dim(mat), c(3, 3))
  expect_equal(unname(diag(mat)), c(2, 1, 1))
  expect_equal(dim(concurrence_matrix(df, x, g, na.rm = TRUE)), c(2, 2))

  tbl <- concurrence_table(df, x, g)
  expect_equal(nrow(tbl), 9)
  expect_true(anyNA(tbl$g_1))
  expect_equal(nrow(concurrence_table(df, x, g, na.rm = TRUE)), 4)
})

test_that("concurrence_table header uses the group variable", {
  df <- expand.grid(var = c("A", "B", "C"), grp = paste0("A", 1:3))
  expect_match(
    pillar::tbl_sum(concurrence_table(df, var, grp))[["Dimension"]],
    "grp$"
  )
})
