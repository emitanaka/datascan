test_that("is_nested identifies nested columns", {
  df <- data.frame(
    site = rep(c("A", "B"), each = 4),
    plot1 = rep(c("A1", "A2", "B1", "B2"), each = 2),
    plot2 = rep(c("A1", "A2", "A1", "A2"), each = 2)
  )

  expect_true(is_nested(df$plot1, df$site))
  expect_false(is_nested(df$plot2, df$site))
  expect_false(is_nested(df$site, df$plot1))
})

test_that("is_nested can remove missing values", {
  plot <- c("A1", "A1", "A2", NA, "B1", "B1", "B2")
  site <- c("A", "A", "A", "A", "B", "B", NA)

  expect_true(is_nested(plot, site, na.rm = TRUE))
})

test_that("is_nested ignores trivial cases by default", {
  id <- 1:4
  site <- c("A", "A", "B", "B")
  site_code <- c("a", "a", "b", "b")
  field <- rep("F1", 4)

  expect_false(is_nested(site, field))
  expect_false(is_nested(id, site))
  expect_false(is_nested(site, site_code))
  expect_false(is_nested(site_code, site))
})

test_that("is_nested can count selected trivial cases", {
  id <- 1:4
  site <- c("A", "A", "B", "B")
  site_code <- c("a", "a", "b", "b")
  field <- rep("F1", 4)

  expect_true(is_nested(site, field, ignore = c("unique", "bijective")))
  expect_false(is_nested(site, field, ignore = "constant"))
  expect_true(is_nested(id, site, ignore = c("constant", "bijective")))
  expect_false(is_nested(id, site, ignore = "unique"))
  expect_true(is_nested(site, site_code, ignore = c("constant", "unique")))
  expect_false(is_nested(site, site_code, ignore = "bijective"))
  expect_true(is_nested(id, site, ignore = NULL))
  expect_true(is_nested(id, site, ignore = character()))
})

test_that("is_nested validates ignore", {
  expect_error(is_nested(1:4, 1:4, ignore = "other"))
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
    site = rep(c("A", "B"), each = 4),
    plot1 = rep(c("A1", "A2", "B1", "B2"), each = 2),
    plot2 = rep(c("A1", "A2", "A1", "A2"), each = 2)
  )

  expect_equal(
    cols_nested(df),
    list(c("plot1", "site"), c("plot1", "plot2"))
  )
})

test_that("cols_nested excludes all unique and bijective columns", {
  df <- data.frame(
    id = 1:8,
    site = rep(c("A", "B"), each = 4),
    block = rep(c("A1", "A2", "B1", "B2"), each = 2),
    block_code = rep(c("a1", "a2", "b1", "b2"), each = 2)
  )

  expect_equal(
    cols_nested(df),
    list(c("block", "site"), c("block_code", "site"))
  )
})

test_that("cols_nested passes ignore to is_nested", {
  df <- data.frame(
    id = 1:4,
    site = c("A", "A", "B", "B"),
    site_code = c("a", "a", "b", "b")
  )

  expect_equal(cols_nested(df), list())
  expect_equal(
    cols_nested(df, ignore = c("constant", "bijective")),
    list(c("id", "site"), c("id", "site_code"))
  )
  expect_equal(
    cols_nested(df, ignore = c("constant", "unique")),
    list(c("site", "site_code"), c("site_code", "site"))
  )
})

test_that("cols_nested validates its input", {
  expect_error(cols_nested(data.frame()))

  duplicated_names <- data.frame(x = 1:2, y = 3:4)
  names(duplicated_names) <- c("x", "x")
  expect_error(cols_nested(duplicated_names))
})
