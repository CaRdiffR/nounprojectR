# make endpoints


#' Making the endpoint for searching Noun Project by Term
#'
#' @param term 
#' @param limit_to_public_domain 
#' @param num_of_imgs 
#' @param offset 
#'
#' @return an url to use with get_nouns_api() 
#' @export
#'
#' @examples
#' # find four icons of dogs
#' url <- make_term_endpoint("dog", num_of_imgs = 4)
#' res <- get_nouns_api(url)
#' result <- httr::content(res)
#' get_pngs_and_show(result)

make_term_endpoint <- function(term,
  limit_to_public_domain = 1,
  num_of_imgs = 2,
  offset = 0){

    term_url <- paste0("icons/", term, "?limit_to_public_domain=",
      limit_to_public_domain, "&limit=",num_of_imgs, "&offset=", offset)
    return(term_url)
}



#' Make simple authorisation url for one icon number
#'
#' @param icon_num a number of the icon you want to download
#'
#' @return the url assembled. 
#'
#' @examples
#' url <- make_icon_num_url(1)
make_icon_num_url <- function(icon_num){
  # objective here is to assemble from the Noun Project API
  # assumption is that you know the number of the icon that you want...
  # an example is icon number 1870346
  # https://thenounproject.com/search/?q=female%20executive&i=1870346
  
  base_url <- "http://api.thenounproject.com/icon/"
  authorisation_url <- paste0(base_url, icon_num)
  return(authorisation_url)
}