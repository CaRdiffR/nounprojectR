context("download icons")

test_that("get icon number 609", {
  result <- get_nouns_api("icon/609")
  image <- get_png(result)
  expect_equal(mode(image), "externalptr")
})

test_that("get dogs", {
  url <- make_term_endpoint("dog", num_of_imgs = 4)
  expect_equal(url, "icons/dog?limit_to_public_domain=1&limit=4&offset=0")
  res <- get_nouns_api(url)
  expect_equal(length(res), 10)
  expect_equal(httr::status_code(res), 200)
  result <- httr::content(res)
  expect_equal(length(result), 2) 
  expect_equal(length(result[2]$icons), 4)
  images <- get_pngs_and_show(result)
  expect_equal(mode(images), "externalptr") 
  expect_equal(length(images), 4)
})
