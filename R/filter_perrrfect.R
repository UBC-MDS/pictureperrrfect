#' This function can be used to build predefined filters.
#'
#' @param kernel_type A string which accepts following values
#'     blur: Used to blur the picture
#'     sharpen: Used to increase the sharpness of the image
#'   More options will be added as enhancements
#' @param kernel_size An integer determining the filter size.
#'
#' @return A matrix of size kernel_size * kernel_size representing the filter.
#'
#' @import imager
#'
#' @export
#'
#' @examples
#' \donttest{
#' build_filter("blur", 3)
#' build_filter("sharpen", 7)
#' }
build_filter <- function(kernel_type, kernel_size) {

  if (magrittr::not(is.numeric(kernel_size))) {
    stop("Invalid filter size.")
  }

  if (kernel_type == "blur") {
    kernel <- matrix(data = rep(0.01, kernel_size * kernel_size), nrow = kernel_size, ncol = kernel_size)
  } else if (kernel_type == "sharpen") {
    kernel <- matrix(data = rep(-1, kernel_size * kernel_size), nrow = kernel_size, ncol = kernel_size)
    kernel[(kernel_size / 2 + 1), (kernel_size / 2 + 1)] <- 5

    for (i in 1:as.integer(kernel_size / 2)) {
      kernel[i, 1:((as.integer(kernel_size / 2) + 1) - i)] <- 0
      kernel[i, (as.integer((kernel_size / 2) + 1 + i):kernel_size)] <- 0
      kernel[(kernel_size) - i + 1, 1:(as.integer(kernel_size / 2) - i + 1)] <- 0
      kernel[(kernel_size) - i + 1, (as.integer(kernel_size / 2) + i + 1):kernel_size] <- 0
    }
  } else {
    stop("Invalid filter type.")
  }
  as.cimg(kernel)
}

#' This function can be used to apply predefined or custom filters on an image.
#'
#' The function can be applied on images represented by cimg object. The users can
#' choose from predefined filters or can create their new filters. This can be used
#' for various purposes like entertainment application or visualization of convolutional
#' neural network.
#'
#' @param image A cimg object to representing the image
#' @param filter_type One of the following values:
#'     "blur": Used to blur the picture
#'     "sharpen": Used to increase the sharpness of the image
#'     "custom": Allows users to use their own filter
#'  More options will be added as enhancements
#' @param filter_size An integer determining the filter size.
#'     This is used if the filter_type is not custom. Default: 3
#' @param custom_filter A 2d matrix that allows users to pass their own filter.
#'     This is only used if the users select filter_type = "custom"
#'
#' @export
#'
#' @return A cimg object representing the transformed image.
#'
#' @examples
#' \donttest{
#' filter_perrrfect(imager::boats, filter_type="blur", filter_size=21L, custom_filter=NULL)
#' filter_perrrfect(imager::boats, filter_type="custom", custom_filter=matrix(0.01, 42, 21))
#'}
filter_perrrfect <- function(image, filter_type = "blur", filter_size = 3, custom_filter = NULL) {
  if (magrittr::not(is.cimg(image))) {
    stop("Invalid image. Image in not a cimg object")
  }

  if (magrittr::not(is.numeric(filter_size))) {
    stop("Invalid filter size.")
  }

  valid_filters <- c("blur", "sharpen", "custom")

  if (magrittr::not(filter_type %in% valid_filters)) {
    stop("Invalid filter type.")
  } else if (filter_type != "custom") {
    if (dim(image)[1] < filter_size | dim(image)[2] < filter_size) {
      stop("Invalid filter dimensions.")
    }

    kernel <- build_filter(filter_type, filter_size)
  } else {
    if (magrittr::not(is.matrix(custom_filter))) {
      stop("custom_filter should be a matrix when filter_type is custom.")
    }
    kernel <- as.cimg(custom_filter)
  }
  image %>% imager::correlate(kernel)
}

