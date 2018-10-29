#' Making the endpoint for searching Noun Project by Term
#'
#' @param term word to use for search
#' @param limit_to_public_domain restrict licence, change to 0 for not limit
#' @param num_of_imgs the number of images required
#' @param offset how many images to ignore, if you want to get different ones
#'
#' @return an url to use with get_nouns_api() 
#' @export
#'
#' @examples
#' \dontrun{
#' # assemble the url to get 4 dog icons
#' url <- nounprojectR::make_term_endpoint("dog", num_of_imgs = 4)
#' # obtain information from the Noun Project server 
#' res <- get_nouns_api(url)
#' # extract the JSON file
#' result <- httr::content(res)
#' # show the images
#' get_pngs_and_show(result)
#' }
make_term_endpoint <- function(term,
                               limit_to_public_domain = 1,
                               num_of_imgs = 2,
                               offset = 0) {
  term_url <- paste0(
    "icons/",
    term,
    "?limit_to_public_domain=",
    limit_to_public_domain,
    "&limit=",
    num_of_imgs,
    "&offset=",
    offset
  )
  return(term_url)
}


#' @title Make the endpoint for an icon url by id
#' @description Accepts id as argument to return partial url
#' @param id numeric id of icon
#' @return partial url string
#' @details pastes
#' @examples 
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @rdname make_id_endpoint
#' @export
make_id_endpoint <- function(id){
  id_url <- paste0("/icon/", id)
  return(id_url)
}
