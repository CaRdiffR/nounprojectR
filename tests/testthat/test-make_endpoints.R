# unit tests for make_endpoints
context("make_term_endpoint")
test_that("make_term_endpoint",{
  result <- make_term_endpoint("dog") 
  expect_equal(result, "icons/dog?limit_to_public_domain=1&limit=2&offset=0")
  result <- make_term_endpoint("dog", limit_to_public_domain = 0) 
  expect_equal(result, "icons/dog?limit_to_public_domain=0&limit=2&offset=0")
  result <- make_term_endpoint("dog", num_of_imgs = 4) 
  expect_equal(result, "icons/dog?limit_to_public_domain=1&limit=4&offset=0")
  result <- make_term_endpoint("dog", offset = 4) 
  expect_equal(result, "icons/dog?limit_to_public_domain=1&limit=2&offset=4")
})
