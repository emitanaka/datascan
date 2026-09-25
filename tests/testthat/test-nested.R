test_that("is_nested identifies nested columns", {
  df <- data.frame(
    site = c("A", "A", "B", "B"),
    plot1 = c("A1", "A2", "B1", "B2"),
    plot2 = c("A1", "A2", "A1", "A2")
  )

  expect_true(is_nested(df$plot1, df$site))
  expect_false(is_nested(df$plot2, df$site))
  expect_false(is_nested(df$site, df$plot1))
})

test_that("is_nested can remove missing values", {
  plot <- c("A1", "A2", NA, "B1", "B2")
  site <- c("A", "A", "A", "B", NA)

  expect_true(is_nested(plot, site, na.rm = TRUE))
})

test_that("is_complete identifies complete columns", {
  site <- c("A", "A", "B", "B")
  complete_plot <- c("P1", "P2", "P1", "P2")
  incomplete_plot <- c("P1", "P2", "P1", "P1")

  expect_true(is_complete(complete_plot, site))
  expect_false(is_complete(incomplete_plot, site))
})

test_that("cols_nested returns each child-parent pair", {
  df <- data.frame(
    site = c("A", "A", "B", "B"),
    plot1 = c("A1", "A2", "B1", "B2"),
    plot2 = c("A1", "A2", "A1", "A2")
  )

  expect_equal(
    cols_nested(df),
    list(c("plot1", "site"), c("plot1", "plot2"))
  )
})

test_that("cols_nested validates its input", {
  expect_error(cols_nested(data.frame()))

  duplicated_names <- data.frame(x = 1:2, y = 3:4)
  names(duplicated_names) <- c("x", "x")
  expect_error(cols_nested(duplicated_names))
})
