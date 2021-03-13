dim_test_df <- as.data.frame(imager::boats)
single_rotation_img <- rotation_perrrfect(boats, 1)
double_rotation_img <- rotation_perrrfect(boats, 2)
triple_rotation_img <- rotation_perrrfect(boats, 3)
cycle_rotation_img <- rotation_perrrfect(boats, 4)

single_rotation_df <- as.data.frame(single_rotation_img)
double_rotation_df <- as.data.frame(double_rotation_img)
triple_rotation_df <- as.data.frame(triple_rotation_img)
cycle_rotation_df <- as.data.frame(cycle_rotation_img)


# Type testing
testthat::test_that("Non-cimg objects should throw error", {
  testthat::expect_error(rotation_perrrfect(1, 1))
  testthat::expect_error(rotation_perrrfect(1:10, 1))
  testthat::expect_error(rotation_perrrfect(matrix(1:10), 1))
  testthat::expect_error(rotation_perrrfect(data.frame(1:10), 1))
  testthat::expect_error(rotation_perrrfect("boats", 1))
  testthat::expect_error(rotation_perrrfect(boats, 5))
})

# Dimension testing
testthat::test_that("Dimensions of image should alternate", {
  testthat::expect_equal(dim(boats), c(256, 384, 1, 3))
  testthat::expect_equal(dim(imager::as.cimg(single_rotation_img)), c(384, 256, 1, 3))
  testthat::expect_equal(dim(imager::as.cimg(double_rotation_img)), c(256, 384, 1, 3))
  testthat::expect_equal(dim(imager::as.cimg(triple_rotation_img)), c(384, 256, 1, 3))
  testthat::expect_equal(dim(imager::as.cimg(cycle_rotation_img)), c(256, 384, 1, 3))
})


# Pixel value testing
testthat::test_that("Dimensions of image should alternate", {
  testthat::expect_equal(
    sum(single_rotation_df$value),
    sum(dim_test_df$value)
  )
  testthat::expect_equal(
    sum(double_rotation_df$value),
    sum(dim_test_df$value)
  )
  testthat::expect_equal(
    sum(triple_rotation_df$value),
    sum(dim_test_df$value)
  )
  testthat::expect_equal(
    sum(cycle_rotation_df$value),
    sum(dim_test_df$value)
  )
})

# Row and column matching testing
testthat::test_that("Dimensions of image should alternate", {
  testthat::expect_equal(
    dim_test_df[dim_test_df$y == 1, "value"],
    single_rotation_df[
      single_rotation_df$x == max(single_rotation_df$x),
      "value"
    ]
  )
  testthat::expect_equal(
    sum(dim_test_df[dim_test_df$y == 1, "value"]),
    sum(double_rotation_df[
      double_rotation_df$y == 384,
      "value"
    ])
  )
  testthat::expect_equal(
    sum(dim_test_df[dim_test_df$y == 1, "value"]),
    sum(rev(triple_rotation_df[triple_rotation_df$x == 1, "value"]))
  )
  testthat::expect_equal(
    dim_test_df[dim_test_df$y == 1, "value"],
    cycle_rotation_df[cycle_rotation_df$y == 1, "value"]
  )
})
