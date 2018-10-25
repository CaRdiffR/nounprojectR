#' Making the endpoint for searching Noun Project by Term
#'
#' @param id
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
