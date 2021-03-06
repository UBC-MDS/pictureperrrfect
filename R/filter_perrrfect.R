#' This function can be used to apply predefined or custom filters on an image.
#'
#' The function can be applied on single channel images. The users can choose from
#' predefined filters or can create their new filters. This can be used for various
#' purposes like entertainment application or visualization of convolutional neural network.
#'
#' @param image A 2D matrix representing the pixel values of an image
#' @param filter_type A string to choose the type of filter. Only "blur", "sharpen" and "custom" values are allowed. Default="blur"
#' @param filter_size An integer determining the filter size. This is used if the filter_type is not custom. Default: 3
#' @param custom_filter A 2D matrix thet allows users to pass their own filter. This is only used if the users select filter_type = "custom"
#'
#' @return A 2D matrix representing the pixel values of the filtered image
#'
#' @examples
#' image <- matrix(1:25, nrow = 5, ncol = 5)
#' filter_perrrfect(image, filter_type="blur")
#'            [,1]      [,2]      [,3]
#' [1,] 0.00000000 0.4166667 0.8333333
#' [2,] 0.08333333 0.5000000 0.9166667
#' [3,] 0.16666667 0.5833333 1.0000000
#'
filter_perrrfect <- function(image, filter_type="blur", filter_size=3, custom_filter=NULL) {
  NULL
}
