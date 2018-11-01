#' Get a PNG file after Noun Project access
#'
#' @param res_from_api JSON result from Noun Project API validation
#'
#' @return a PNG pointer that can be shown in the viewer 
#' @export
#'
#' @examples
#' # this will show an airplane
#' res <- get_nouns_api("icon/609")
#' get_png(res)
get_png <- function(res_from_api){
  check_np_response(res_from_api)
  # PNG can be downloaded using image_read() from magick
  png_image <- magick::image_read(httr::content(res_from_api)$icon$preview_url)
  return(png_image)
}



#' Download PNG for the icons in a list from get_icon_by_term() 
#'
#' @param icon_lists List of details about icons from Noun Project supplied by
#' the function get_icon_by_term() (may be useful for other functions too)
#'
#' @return group of images in a PNG format
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
get_pngs_and_show <- function(icon_lists) {
    # they all contain PNGs - can be downloaded using image_read() from magick
    png_images <- magick::image_read(icon_lists$icons[[1]]$preview_url)
    icons <- NULL
    for (i in 2:length(icon_lists$icons)) {
        icons <- magick::image_read(icon_lists$icons[[i]]$preview_url)
        png_images <- c(png_images, icons)
    }
    return(png_images)
}