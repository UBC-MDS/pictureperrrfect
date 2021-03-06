#' This function uses a lossy pooling algorithm to compress an image.
#'
#' The function can be applied to single channel or 3-channel images. The user passes
#' an image which is to be compressed and the resulting compressed numpy array is returned.
#' The user can also specify the pooling algorithm to be used and the size of the kernel
#' to apply over the image.
#''
#' @param image A 2D or 3D matrix representing a single channel or 3-channel image.
#' @param kernel_size The size of the length and width of the kernel to be passed over the image. Default: 2
#' @param pooling_function The pooling algorithm to be used. Three options: "max", "min", and "mean". Default: "max"
#'
#' @return A 2D or 3D matrix representing a single channel or 3-channel image.
#'
#' @examples
#' image <- matrix(1:16, nrow = 4, ncol = 4)
#' compression_perrrfect(image, kernel_size=2, pooling_function="max")
#'      [,1] [,2] 
#' [1,]   6   14 
#' [2,]   8   16 
#'
compression_perrrfect <- function(image, kernel_size=2, pooling_function="max") {
  NULL
}
