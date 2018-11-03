#' Set credentials as system variables
#'
#' @param appname you appname from https://thenounproject.com/developers/apps/
#' @param key your key from https://thenounproject.com/developers/apps/
#' @param secret your secret from https://thenounproject.com/developers/apps/
#'
#' @return invisibly as System Environmental variables: `NOUNS_API_KEY` and `NOUNS_API_SECRET`
#' @export
#'
#' @examples
#' np_credentials("appname", "your-noun-project-key", "your-noun-project-secret")
np_credentials <- function(appname, key, secret) {
  Sys.setenv(NOUNS_API_APPNAME = appname)
  Sys.setenv(NOUNS_API_KEY = key)
  Sys.setenv(NOUNS_API_SECRET = secret)
}




















