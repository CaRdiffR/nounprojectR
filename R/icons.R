#' Search Noun Project using a Term using Python authentication
#'
#' @param term word for which you would like to search on Noun Project site
#' @param num_of_imgs the number of images you would like to get (default = 4 )
#' @param limit_to_public_domain enter 0 for NO or 1 for YES (default YES)
#' @param offset how many images would you like to skip (default 0)
#'
#' @return gives a list of image details including urls from which they can be
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
  if (httr::status_code(resp) == 403)
    stop(paste("NounProject API error - Permission denied.",
               "Have you set your credentials using np_credentials() function?"))
  if (httr::status_code(resp) != 200) {
    warning("NounProject API error - most likely invalid search term given.")
    return(list())
  }
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

#' Display many icons
#' 
#' Displays first num_of_imgs (default 4) icons from The Noun Project.
#' It searches through public domain licensed icons only!
#'
#' @param icon_name character with name of icon to search in nounproject
#' @param num_of_imgs number of images to display (default 4)
#'
#' @return group of images in a PNG format
#' @export
display_many_icons <- function(icon_name, num_of_imgs = 4) {
  url <- make_term_endpoint(icon_name, num_of_imgs = num_of_imgs)
  res <- get_nouns_api(url)
  check_np_response(res)
  result <- httr::content(res)
  get_pngs_and_show(result)
}
