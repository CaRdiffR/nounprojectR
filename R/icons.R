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
  # check response
  if (httr::status_code(resp) != 200)
    stop("NounProject API error - most likely invalid search term given.")
  httr::content(resp)
}

#' Get icons urls
#'
#' @param icon_list list of icons from \code{get_icon_by_term}
#'
#' @return list with field .$url containing url and
#' .$id with icon id as character
#' @export
get_icons_urls <- function(icon_list) {
  lapply(icon_list$icons, function(x) list(url=x$preview_url, id=x$id))
}

#' Display icon
#'
#' @param icon_number character or string with icon code eg. 13094
#'
#' @return image details and shows image in viewer
#' @export
#'
#' @examples
#' \dontrun{
#' display_icon(13094)
#' }
display_icon <- function(icon_number) {
  icon_number <- as.character(icon_number)
  res <- get_nouns_api(paste0("icon/", icon_number)) 
  get_png(res)
}
