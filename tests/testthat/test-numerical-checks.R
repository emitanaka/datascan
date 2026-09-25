test_that("numerical check", {
  expect_true(is_numerical(c(1, 2, 3)))
  expect_true(is_numerical(c("1", "2", "3")))
  expect_false(is_numerical(c("1", "2", "3", "A")))
  expect_equal(as_numerical(c("1", "2", "A", "4", "B")), c(1, 2, NA, 4, NA))
})

test_that("numerical check uses factor labels", {
  expect_equal(as_numerical(factor(c("10", "5", "20"))), c(10, 5, 20))
  expect_equal(as_numerical(factor(c("10", "A", NA))), c(10, NA, NA))
  expect_true(is_numerical(factor(c("10", "5", "20"))))
  expect_false(is_numerical(factor(c("10", "A"))))
})
