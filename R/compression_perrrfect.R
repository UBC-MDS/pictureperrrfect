library(imager)
library(reticulate)
library(abind)

#' This function uses a lossy pooling algorithm to compress an image.
#'
#' The function can be applied to a greyscale or colour image. The user passes
#' a cimg type object (from the imager package) which is to be compressed and the resulting
#' compressed cimg object is returned. The user can also specify the pooling algorithm to be
#' used and the size of the kernel to apply over the image.
#'
#' @param img A cimg type object of 4 dimensions representing a greyscale or colour image.
#' @param kernel_size The size of the length and width of the kernel to be passed over the image. Default: 2
#' @param pooling_function The pooling algorithm to be used. Three options: "max", "min", and "mean". Default: "max"
#'
#' @return A cimg type image of 4 dimensions representing a greyscale or colour image.
#'
#' @import imager
#' @import reticulate
#' @import abind
#' @importFrom imager as.cimg
#'
#' @export
#'
#' @examples
#' img <- imager::as.cimg(imager::boats)
#' compression_perrrfect(img, kernel_size=2, pooling_function="max")
compression_perrrfect <- function(img, kernel_size=2, pooling_function="max") {
    check_values(img, kernel_size)

    # Check for a valid pooling_function input
    if (pooling_function == "max"){
        pool_func = "max"
    } else if(pooling_function == "min"){
        pool_func = "min"
    } else if(pooling_function == "mean"){
        pool_func = "mean"
    } else{
        stop("The pooling_function argument only takes a value of 'max', 'min', or 'mean'.")
    }

    # If image is not divisible by the kernel_size
    # crop off the right side columns and the bottom rows
    divisible_row = dim(img)[2] %/% kernel_size * kernel_size
    divisible_col = dim(img)[1] %/% kernel_size * kernel_size

    # If image is greyscale, compress just one colour band
    if (dim(img)[4] == 1){

        cropped_img = img[1:divisible_col, 1:divisible_row,,]
        cropped_img <- as.cimg(cropped_img)
        b1 = pool_band(cropped_img[,,,1], kernel_size, pool_func)
        return (b1)
    } else{
        # If image is colour, compress all 3 colour bands
        cropped_img = img[1:divisible_col, 1:divisible_row,,]
        cropped_img <- as.cimg(cropped_img)

        # Pool the 3 colour bands
        b1 = pool_band(cropped_img[,,,1], kernel_size, pool_func)
        b2 = pool_band(cropped_img[,,,2], kernel_size, pool_func)
        b3 = pool_band(cropped_img[,,,3], kernel_size, pool_func)

        # Combine the 3 colour bands
        all_bands <- abind(b1, b2, b3, along=4)
        all_bands <- as.cimg(all_bands)

        return(all_bands)
    }
}

#' This function is to be used in conjunction with compression_pyfect
#' and compresses a single colour band of an image.
#'
#' The function applies a lossy pooling algorithm to compress the specified
#' colour band and the resulting cimg object is returned.
#'
#' @param img A 'matrix' 'array' type object of 2 dimensions representing a color band
#' of either a greyscale image or a colour image.
#' @param kernel_size The size of the length and width of the kernel to be passed over the image. Default: 2
#' @param pooling_func The pooling algorithm to be used. Three options: "max", "min", and "mean". Default: "max"
#'
#' @return A cimg type image of 4 dimensions representing a greyscale or colour image.
#'
#' @export
#'
#' @examples
#' img <- imager::as.cimg(imager::boats)
#' pool_band(img[,,,1], kernel_size=2, pooling_func="max")
pool_band <- function(img, kernel_size, pooling_func){
    col <- dim(img)[1]%/%kernel_size
    row <- dim(img)[2]%/%kernel_size

    pool_colour_band <- img
    # Transpose to prepare for row major order
    pool_colour_band <- t(pool_colour_band)

    total_pix <- dim(img)[1] * dim(img)[2]

    # Read in the array in row major order
    pool_colour_band <- array_reshape(pool_colour_band, c(total_pix/kernel_size, kernel_size), order="C")
    pool_colour_band <- matrix(apply(pool_colour_band, 1, pooling_func))
    pool_colour_band <- array_reshape(pool_colour_band, c(dim(img)[2], col), order="C")

    # Code referenced from here:
    # https://www.w3resource.com/r-programming-exercises/matrix/r-programming-matrix-exercise-12.php
    pool_colour_band <- t(apply(pool_colour_band, 2, rev))
    pool_colour_band <- array_reshape(pool_colour_band, c(dim(img)[2] * dim(img)[1]/kernel_size^2, kernel_size), order="C")
    pool_colour_band <- matrix(apply(pool_colour_band, 1, pooling_func))
    pool_colour_band <- array_reshape(pool_colour_band, c(col, row), order="C")

    pool_colour_band <- t(apply(pool_colour_band, 2, rev))
    pool_colour_band <- t(apply(pool_colour_band, 2, rev))
    pool_colour_band <- t(apply(pool_colour_band, 2, rev))

    # Transpose back to prepare for cimg column major order
    pool_colour_band <- t(pool_colour_band)
    single_band <- as.cimg(pool_colour_band)
    return (single_band)
}

#' This function is to be used in conjunction with compression_pyfect.
#'
#' This function checks that the img and kernel size are valid inputs
#' and stops with an error if not.
#'
#' @param img A cimg type object of 4 dimensions representing a greyscale or colour image.
#' @param kernel_size The size of the length and width of the kernel to be passed over the image. Default: 2
#'
#' @return
#'
#' @export
#'
#' @examples
#' img <- imager::as.cimg(imager::boats)
#' check_values(img, kernel_size=2)
check_values <- function(img, kernel_size){

    # Image must be a cimg type
    if (!imager::is.cimg(img)) {
        stop("Cannot process a non-cimg object")
    }

    if(!kernel_size%%1 == 0){
        stop("kernel_size must be a positive whole number greater than 0.")
    }

    if(kernel_size < 1){
        stop("kernel_size must be a positive whole number greater than 0.")
    }

    # Check that the kernel_size is smaller than the image height and width
    if(dim(img)[1] < kernel_size | dim(img)[2] < kernel_size){
        stop("The kernel size must not be larger than the height or width of the input image array.")
    }
}
