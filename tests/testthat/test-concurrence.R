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
