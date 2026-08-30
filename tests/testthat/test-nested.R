test_that("nested works", {
  df <- data.frame(
    site = c("A", "A", "B", "B"),
    plot1 = c("A1", "A2", "B1", "B2"),
    plot2 = c("A1", "A2", "A1", "A2")
  )
  expect_true(is_nested(df$plot1, df$site))
  expect_false(is_nested(df$plot2, df$site))
})
