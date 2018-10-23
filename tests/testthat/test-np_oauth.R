context("np_oauth")

test_that("send a request - no keys", {
  # should give error message
  result <- httr::GET("http://api.thenounproject.com/icon/1")
  expect_equal(httr::status_code(result), 400)
})


test_that("send request - icon number 15", {
  result <- get_nouns_api("icon/15")
  expect_equal(httr::status_code(result), 200)
  expect_equal(mode(httr::content(result)), "list")
  expect_equal(length(httr::content(result)), 1)
  return <- httr::content(result)$icon
  expect_equal(mode(return), "list")
  expect_equal(length(return), 23)
  expect_equal(return$id, "15")  
})

test_that("send request - collections", {
  result <- get_nouns_api("collections")
  expect_equal(httr::status_code(result), 200)
  expect_equal(mode(httr::content(result)), "list")
  expect_equal(length(httr::content(result)), 1)
  return <- httr::content(result)$collections
  expect_equal(mode(return), "list")
  expect_equal(length(return), 50)
})
