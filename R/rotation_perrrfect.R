#' rotation_perrrfect rotates an image in matrix form by
#' either 90, 180, 270, or 360 degrees.
#'
#' @param image imager::cimg of pixel values to be rotated
#' @param n_rot Integer number of 90-degree rotations to return
#'
#' @return imager::cimg of rotated pixel values
#'
#' @import imager
#' @import tidyverse
#'
#' @export
#'
#' @examples
#' \donttest{
#' rotation_perrrfect(imager::boats, 1)
#' }
rotation_perrrfect <- function(image, n_rot) {
  # Type testing
  if(!imager::is.cimg(image)){
    stop("Cannot rotate a non-cimg object")
  }

  if(!(n_rot %in% 1:4)){
    stop("Can only perform counter-clockwise rotation 1-4 times")
  }

  # Convert to dataframe
  image_df <- as.data.frame(image)

  # Assign number of rotations
  if (n_rot == 1) {
    rotate <- 3
  }
  if (n_rot == 2) {
    rotate <- 2
  }
  if (n_rot == 3) {
    rotate <- 1
  }
  if (n_rot == 4) {
    rotate <- 4
  }

  while (rotate > 0) {

    # Loop through channels
    for (i in 1:max(image_df["cc"])) {
      # Get channel
      channel_df <- image_df %>%
        dplyr::filter(cc == i) %>%
        as.data.frame()

      # Convert to matrix
      channel_mat <- xtabs(value ~ x + y, data = channel_df)

      # Apply rotation
      rotated_mat <- t(apply(channel_mat, 2, rev))

      # Convert back to dataframe
      rotated_df <- data.frame(x=as.vector(row(rotated_mat)),
                            y=as.vector(col(rotated_mat)),
                            value=as.vector(rotated_mat))

      # Re-add channel column
      rotated_df['cc'] <- i

      # Initialize rotated_image
      if (i == 1) {
        rotated_image <- rotated_df
      } else {
        rotated_image <- rbind(rotated_image, rotated_df)
      }

    }
    # Update rotations
    rotate <- rotate - 1

    # Update image
    image_df <- rotated_image
  }

  # Export
  suppressWarnings(imager::as.cimg(image_df))
}
