# load images
# white_image <- load.image(here::here("img", "white.png"))
# black_image <- load.image(here::here("img", "black.png"))
# red_image <- load.image(here::here("img", "red.png"))
# green_image <- load.image(here::here("img", "green.png"))
# blue_image <- load.image(here::here("img", "blue.png"))

white_image <- load.image("../img/white.png")
black_image <- load.image("../img/black.png")
red_image <- load.image("../img/red.png")
green_image <- load.image("../img/green.png")
blue_image <- load.image("../img/blue.png")

# obtain statistics
white_image_stats <- get_property_perrrfect(white_image)
black_image_stats <- get_property_perrrfect(black_image)
red_image_stats <- get_property_perrrfect(red_image)
green_image_stats <- get_property_perrrfect(green_image)
blue_image_stats <- get_property_perrrfect(blue_image)

# input type testing
testthat::test_that("Non-cimg objects should throw error", {
    testthat::expect_error(get_property_perrrfect(1))
    testthat::expect_error(get_property_perrrfect(c(1,2,3)))
    testthat::expect_error(get_property_perrrfect(list(1,2,3)))
    testthat::expect_error(get_property_perrrfect(matrix(1:10)))
    testthat::expect_error(get_property_perrrfect(data.frame(1:10)))
    testthat::expect_error(get_property_perrrfect("string"))
})

# image dimension testing
testthat::test_that("Width and height of images match", {
    testthat::expect_equal(white_image_stats$width, 150)
    testthat::expect_equal(black_image_stats$width, 150)
    testthat::expect_equal(red_image_stats$width, 150)
    testthat::expect_equal(green_image_stats$width, 150)
    testthat::expect_equal(blue_image_stats$width, 150)
    testthat::expect_equal(white_image_stats$height, 200)
    testthat::expect_equal(black_image_stats$height, 200)
    testthat::expect_equal(red_image_stats$height, 200)
    testthat::expect_equal(green_image_stats$height, 200)
    testthat::expect_equal(blue_image_stats$height, 200)
})

# image pixels testing
testthat::test_that("Total pixels of images should match", {
    testthat::expect_equal(white_image_stats$pixels, 30000)
    testthat::expect_equal(black_image_stats$pixels, 30000)
    testthat::expect_equal(red_image_stats$pixels, 30000)
    testthat::expect_equal(green_image_stats$pixels, 30000)
    testthat::expect_equal(blue_image_stats$pixels, 30000)
})

# image Red channel mean and median testing
testthat::test_that("Mean and median of images Red channel should match", {
    testthat::expect_equal(white_image_stats$R, c(1, 1))
    testthat::expect_equal(black_image_stats$R, c(0, 0))
    testthat::expect_equal(red_image_stats$R, c(1, 1))
    testthat::expect_equal(green_image_stats$R, c(0, 0))
    testthat::expect_equal(blue_image_stats$R, c(0, 0))
})

# image Green channel mean and median testing
testthat::test_that("Mean and median of images Green channel should match", {
    testthat::expect_equal(white_image_stats$G, c(1, 1))
    testthat::expect_equal(black_image_stats$G, c(0, 0))
    testthat::expect_equal(red_image_stats$G, c(0, 0))
    testthat::expect_equal(green_image_stats$G, c(1, 1))
    testthat::expect_equal(blue_image_stats$G, c(0, 0))
})

# image Blue channel mean and median testing
testthat::test_that("Mean and median of images Blue channel should match", {
    testthat::expect_equal(white_image_stats$B, c(1, 1))
    testthat::expect_equal(black_image_stats$B, c(0, 0))
    testthat::expect_equal(red_image_stats$B, c(0, 0))
    testthat::expect_equal(green_image_stats$B, c(0, 0))
    testthat::expect_equal(blue_image_stats$B, c(1, 1))
})
