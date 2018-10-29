#' Access Noun Project API with authorisation
#'
#' @param endpoint 
#' @param baseurl url for the Noun Project API
#' @param appname
#'#'
#' @return JSON object
#' @export
#'
#' @examples
#' 
get_nouns_api <- function(endpoint,
                          baseurl = "http://api.thenounproject.com/") {
  nouns_app <- httr::oauth_app(
    appname = Sys.getenv("NOUNS_API_APPNAME"),
    key = Sys.getenv("NOUNS_API_KEY"),
    secret = Sys.getenv("NOUNS_API_SECRET")
  )
  url <- httr::modify_url(baseurl, path = endpoint)
  info <- httr::oauth_signature(url, app = nouns_app)
  header_oauth <- httr::oauth_header(info)
  httr::GET(url, header_oauth)
}

#' Check Noun Project Response
#'
#' @param resp response from np api
check_np_response <- function(resp) {
  if (httr::status_code(resp) == 403)
    stop(paste("NounProject API error - Permission denied.",
               "Have you set your credentials using np_credentials() function?"))
  if (httr::status_code(resp) != 200) {
    stop("NounProject API error - check your query")
  }
}
