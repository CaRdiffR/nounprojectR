#' Get an icon by number using Python authentication
#'
#' @param key provided when you register an app on Noun Project website 
#' @param secret provided when you register an app on Noun Project website
#' @param url url created by make_icon_num_url() function.
#' @param python_path location of python on your computer
#'
#'
#' @return list (JSON object) with links to icons
#'
#' @examples
#' \dontrun{
#' key <- my_key
#' secret <- my_secret
#' icon_number <- 1
#' url <- make_icon_num_url(icon_number)
#' output <- np_oauth(key, secret, url) # output is a list
#' # access PNG using image_read() from magick
#' img2 <- magick::image_read(output$icon$preview_url)
#' img2  # show image - for icon_number of 1 it is a man putting litter in a bin
#' }
np_oauth <- function(key, secret, url, python_path = Sys.which("python")){
  # objective here is to download the SVG file from the Noun Project API
  # assumption is that you know the number of the icon that you want...
  # I can't get the authorisation to work in R but I can in python...
  # use this to make it work...
  # you need to add the reference to your python 3.6
  reticulate::use_python(python_path,
                         required = TRUE)
  reticulate::py_available(initialize = TRUE)
  
  # the python script in python runs authentication
  # and writes JSON file...
  # this is in the package but I can't make the file paths work...
  reticulate::source_python("../nounprojectR/python_script/just_authenticate_function.py")
  
  output <- noun_auth(key, secret, url)
  
  return(output)
}



#' Search Noun Project using a Term using Python authentication
#'
#' @param key provided when you register an app on Noun Project website 
#' @param secret provided when you register an app on Noun Project website
#' @param term word for which you would like to search on Noun Project site
#' @param num_of_imgs the number of images you would like to get
#' @param limit_to_public_domain enter 0 for NO or 1 for YES
#' @param offset how many images would you like to skip
#'
#' @return gives a list of image details including urls from which they can be
#' accessed
#' 
#'
#' @examples
#' \dontrun{
#' key <- my_key
#' secret <- my_secret
#' term = "elephant"
#' icon_lists <- get_icon_by_term(term)  # gets details of two icons
#' elephants <- get_pngs_and_show(icon_lists)  # download icons
#' magick::image_append(elephants)  # show icons - two elephants
#' }
get_icon_by_term_python <- function(key,
                             secret,
                             term,
                             num_of_imgs = 2,
                             limit_to_public_domain = 1,
                             offset = 0) {
  # resulting url:
  # https://api.thenounproject.com/icons/dog?limit_to_public_domain=0&limit=2
  # let's make it...
  base_url <- "https://api.thenounproject.com/icons/"
  
  authorisation_url <-
    paste0(
      base_url,
      term,
      "?limit_to_public_domain=",
      limit_to_public_domain,
      "&limit=",
      num_of_imgs,
      "&offset=",
      offset
    )
  
  # objective here is to download the SVG files from the Noun Project API
  # assumption is that you know the number of the icon that you want...
  
  
  # I can't get the authorisation to work in R but I can in python...
  # use this to make it work...
  # you need to add the reference to your python 3.6
  reticulate::use_python(python_path,
                         required = TRUE)
  reticulate::py_available(initialize = TRUE)
  
  # the python script in python runs authentication
  # and writes JSON file...
  # this is in the package but I can't make the file paths work...
  reticulate::source_python("../nounprojectR/python_script/just_authenticate_function.py")
  output <- noun_auth(key, secret, authorisation_url)
  return(output)
  # output is List of 2, generated at and a list of icons
  # inside icons is a List of
  # locations fail after time...
}

#' Make simple authorisation url for one icon number
#'
#' @param icon_num a number of the icon you want to download
#'
#' @return the url assembled
make_icon_num_url <- function(icon_num){
  # objective here is to assemble from the Noun Project API
  # assumption is that you know the number of the icon that you want...
  # an example is icon number 1870346
  # https://thenounproject.com/search/?q=female%20executive&i=1870346
  
  base_url <- "http://api.thenounproject.com/icon/"
  authorisation_url <- paste0(base_url, icon_num)
  return(authorisation_url)
}