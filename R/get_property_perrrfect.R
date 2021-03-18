library(imager)

#' This function will get the image property of a image.
#'
#' @param image imager::cimg image to obtain image information
#'
#' @return  a list of image dimensions, pixels, and each channel's mean and median
#'
#' @import imager
#' @importFrom stats median xtabs
#'
#' @export
#'
#' @examples
#' get_property_perrrfect(imager::boats)
get_property_perrrfect <- function(image) {
    # error handling
    if (!imager::is.cimg(image)) {
        stop("Cannot process a non-cimg object")
    }

    # convert image to data frame for manipulation
    image <- as.data.frame(image)

    # calculate to extract insights from image
    width <- max(image$x)
    height <- max(image$y)
    red_channel <- image[image$cc == 1,]$value
    green_channel <- image[image$cc == 2,]$value
    blue_channel <- image[image$cc == 3,]$value

    # output image statistics
    list("width" = width,
         "height" = height,
         "pixels" = width * height,
         "R" = c(mean(red_channel), median(red_channel)),
         "G" = c(mean(green_channel), median(green_channel)),
         "B" = c(mean(blue_channel), median(blue_channel))
    )
}
