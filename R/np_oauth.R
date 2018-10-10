#' Title
#'
#' @param key provided when you register an app on Noun Project website 
#' @param secret provided when you register an app on Noun Project website
#' @param icon_num number on the Noun Project website that corresponds to an icon that 
#' you would like to download
#'
#' @return JSON object with links to icons
#' @export
#'
#' @examples
np_oauth <- function(key, secret, icon_num){
  # objective here is to download the SVG file from the Noun Project API
  # assumption is that you know the number of the icon that you want...
  
  # complication: some icons seem to only have PNG; some have both PNG and SVG
  
  # an example is icon number 1870346
  # https://thenounproject.com/search/?q=female%20executive&i=1870346
  
  base_url <- "http://api.thenounproject.com/icon/"
  authorisation_url <- paste0(base_url, icon_num)
  
  # I can't get the authorisation to work in R but I can in python...
  # use this to make it work...
  # you need to add the reference to your python 3.6
  reticulate::use_python("/Library/Frameworks/Python.framework/Versions/3.6/bin/python3.6",
    required = TRUE)
  reticulate::py_available(initialize = TRUE)
  
  # the python script in python runs authentication
  # and writes JSON file...
  # this is in the package but I can't make the file paths work...
  reticulate::source_python("../nounprojectR/python_script/just_authenticate_function.py")
  
  output <- noun_auth(key, secret, authorisation_url)
  
  return(output)
}