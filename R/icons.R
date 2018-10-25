#' Search Noun Project using a Term using Python authentication
#'
#' @param term word for which you would like to search on Noun Project site
#' @param num_of_imgs the number of images you would like to get (default = 4 )
#' @param limit_to_public_domain enter 0 for NO or 1 for YES (default YES)
#' @param offset how many images would you like to skip (default 0)
#'
#' @return ives a list of image details including urls from which they can be
#' accessed
#' @export
#'
#' @examples
#' \dontrun{
#' get_icon_by_term("dog")
#' }
get_icon_by_term <- function(term, num_of_imgs=4, limit_to_public_domain=1, offset=0) {
  term_ep <- make_term_endpoint(term, limit_to_public_domain, num_of_imgs, offset)
  resp <- get_nouns_api(term_ep)
  httr::content(resp)
}
  
