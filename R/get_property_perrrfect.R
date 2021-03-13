library(imager)

#' This function will get the image property of a image.
#'
#' @param image imager::cimg image to obtain image information
#'
#' @return  a list of image dimensions, pixels, and each channel's mean and median
#'
#' @examples
#' get_property_perrrfect(image) # all black image
#' $width
#' [1] 150
#'
#' $height
#' [1] 200
#'
#' $pixels
#' [1] 30000
#'
#' $R
#' [1] 0 0
#'
#' $G
#' [1] 0 0
#'
#' $B
#' [1] 0 0

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
