library(imager)
dim_test_df <- as.data.frame(boats)
single_roation <- rotation_perrrfect(boats, 1)
double_roation <- rotation_perrrfect(boats, 2)
triple_roation <- rotation_perrrfect(boats, 3)
cycle_roation <- rotation_perrrfect(boats, 4)


# Type testing
test_that("Non-cimg objects should throw error", {
  expect_error(rotation_perrrfect(1, 1))
  expect_error(rotation_perrrfect(1:10, 1))
  expect_error(rotation_perrrfect(matrix(1:10), 1))
  expect_error(rotation_perrrfect(data.frame(1:10), 1))
  expect_error(rotation_perrrfect("boats", 1))
})

# Dimension testing
test_that("Dimensions of image should alternate", {
  expect_equal(dim(boats), c(256, 384, 1, 3))
  expect_equal(dim(as.cimg(single_rotation)), c(384, 256, 1, 3))
  expect_equal(dim(as.cimg(double_rotation)), c(256, 384, 1, 3))
  expect_equal(dim(as.cimg(triple_rotation)), c(384, 256, 1, 3))
  expect_equal(dim(as.cimg(cycle_rotation)), c(256, 384, 1, 3))
})


# Pixel value testing
test_that("Dimensions of image should alternate", {
  expect_equal(sum(single_rotation$value),
               sum(dim_test_df$value))
  expect_equal(sum(double_rotation$value),
               sum(dim_test_df$value))
  expect_equal(sum(triple_rotation$value),
               sum(dim_test_df$value))
  expect_equal(sum(cycle_rotation$value),
               sum(dim_test_df$value))
})

# Row and column matching testing
test_that("Dimensions of image should alternate", {
  expect_equal(dim_test_df[dim_test_df$y == 1,"value"],
               single_rotation[single_rotation$x == max(single_roation$x),
                               "value"])
  expect_equal(dim_test_df[dim_test_df$y == 1,"value"],
               rev(double_rotation[double_rotation$y == max(double_roation$y),
                                   "value"]))
  expect_equal(dim_test_df[dim_test_df$y == 1,"value"],
               rev(triple_rotation[triple_rotation$x == 1, "value"]))
  expect_equal(dim_test_df[dim_test_df$y == 1,"value"],
               cycle_rotation[cycle_rotation$y == 1, "value"])
})
