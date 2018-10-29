#' Download PNG for the icons in a list from get_icon_by_term() 
#'
#' @param icon_lists List of details about icons from Noun Project supplied by
#' the function get_icon_by_term() (may be useful for other functions too)
#'
#' @return group of images in a PNG format
#' @export
#'
#' @examples
#' elephants <- get_pngs_and_show(icon_lists)  # download icons
#' magick::image_append(elephants)  # show icons - two elephants
get_pngs_and_show <- function(icon_lists) {
  # they all contain PNGs - can be downloaded using image_read() from magick
  png_images <-
    magick::image_read(icon_lists$icons[[1]]$preview_url)
  icons <- NULL
  for (i in 2:length(icon_lists$icons)) {
    icons <- magick::image_read(icon_lists$icons[[i]]$preview_url)
    png_images <- c(png_images, icons)
  }
  return(png_images)
}

