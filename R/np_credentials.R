#' Set credentials as system variables
#'
#' @param key your key from https://thenounproject.com/developers/apps/
#' @param secret your secret from https://thenounproject.com/developers/apps/
#'
#' @return invisibly as System Environemtnal variables: `NOUNS_API_KEY` and `NOUNS_API_SECRET`
#' @export
#'
#' @examples
np_credentials <- function(key, secret) {
  Sys.setenv(NOUNS_API_KEY = key)
  Sys.setenv(NOUNS_API_SECRET = secret)
}




















