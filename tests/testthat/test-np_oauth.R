context("np_oauth")

test_that("np_oauth works as expected", {
  result <- np_oauth(your_key,
    your_secret, 1870346)
  expect_equal(mode(result), "list")
})