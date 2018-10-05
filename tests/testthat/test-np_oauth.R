context("np_oauth")

test_that("np_oauth works as expected", {
  result <- np_oauth()
  check <- 1
  expect_equal(result, check)
})