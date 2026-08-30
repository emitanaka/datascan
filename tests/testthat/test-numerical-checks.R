test_that("numerical check", {
  expect_true(is_numerical(c(1, 2, 3)))
  expect_true(is_numerical(c("1", "2", "3")))
  expect_false(is_numerical(c("1", "2", "3", "A")))
  expect_equal(as_numerical(c("1", "2", "A", "4", "B")), c(1, 2, NA, 4, NA))
})
