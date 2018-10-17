context("np_oauth")

test_that("make_icon_num_url", {
  result <- make_icon_num_url(1)
  check <- "http://api.thenounproject.com/icon/1"
  expect_equal(result, check)
})

test_that("send a request - no keys", {
  # should give error message
  result <- httr::GET("http://api.thenounproject.com/icon/1")
  expect_equal(httr::status_code(result), 400)
})