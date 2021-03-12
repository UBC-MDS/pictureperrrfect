###########################################################################################################
library(imager)
input_image <- load.image("img/input_beautiful_Vancouver.jpg")
output_beautiful_Vancouver_blur_21 <- load.image("img/output_beautiful_Vancouver_blur_21.jpg")
output_beautiful_Vancouver_sharpen_21 <- load.image("img/output_beautiful_Vancouver_sharpen_21.jpg")
###########################################################################################################
test_image = filter_perrrfect(input_image, filter_type="sharpen", filter_size=21, custom_filter=NULL)

testthat::test_that("check all errors", {
  testthat::expect_error(test_imagefilter_perrrfect(input_image, filter_type="abc"))
  testthat::expect_error(test_imagefilter_perrrfect("input_image", filter_type="abc"))
  testthat::expect_error(filter_perrrfect(input_image, filter_type="sharpen", filter_size=5000, custom_filter=NULL))
  testthat::expect_error(filter_perrrfect(input_image, filter_type="custom", filter_size=21, custom_filter=NULL))
  testthat::expect_error(build_filter("abc", 7))
  testthat::expect_error(build_filter("blur", "7"))
})
###########################################################################################################
# Test sharpen image
testthat::test_that("output type incorrect for sharpen tests", {
  testthat::expect_true(is.cimg(test_image))
})

imager::save.image(test_image,"img/temp_image.jpg")
temp_image  <- load.image("img/temp_image.jpg")

testthat::test_that("regression test sharpen", {
  testthat::expect_identical(temp_image, output_beautiful_Vancouver_sharpen_21)
})
###########################################################################################################
# Test blur image
test_image = filter_perrrfect(input_image, filter_type="blur", filter_size=21, custom_filter=NULL)
testthat::test_that("output type incorrect for blur tests", {
  testthat::expect_true(is.cimg(test_image))
})

imager::save.image(test_image,"img/temp_image.jpg")
temp_image  <- load.image("img/temp_image.jpg")

testthat::test_that("regression test blur", {
  testthat::expect_identical(temp_image, output_beautiful_Vancouver_blur_21)
})
###########################################################################################################
# Test custom filtered image
test_image = filter_perrrfect(input_image, filter_type="custom", filter_size=21, custom_filter=matrix(0.01, 21, 21))
testthat::test_that("output type incorrect for custom tests", {
  testthat::expect_true(is.cimg(test_image))
})

imager::save.image(test_image,"img/temp_image.jpg")
temp_image  <- load.image("img/temp_image.jpg")

testthat::test_that("regression test custom", {
  testthat::expect_identical(temp_image, output_beautiful_Vancouver_blur_21)
})

###########################################################################################################
# Test predefined filter definition

expected_blur_filter_5 <- as.cimg(matrix(data = rep(0.01, 25), nrow = 5, ncol = 5))
expected_sharpen_filter_7 <- as.cimg(matrix(
  c(0, 0, 0, -1, 0, 0, 0, 0, 0, -1, -1, -1, 0, 0, 0, -1, -1, -1, -1, -1, 0, -1, -1, -1, 5, -1, -1, -1, 0, -1, -1, -1, -1, -1, 0, 0, 0, -1, -1, -1, 0, 0, 0, 0, 0, -1, 0, 0, 0),
  nrow = 7, ncol = 7
))

testthat::test_that("regression test custom", {
  testthat::expect_identical(build_filter("blur", 5), expected_blur_filter_5)
  testthat::expect_identical(build_filter("sharpen", 7), expected_sharpen_filter_7)
})
