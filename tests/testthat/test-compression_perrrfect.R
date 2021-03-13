# Turn off warnings for these tests
options(warn=-1)

# Test data
col1 <- array(c(5,4,3))
col2 <- array(c(2,2,1))
col3 <- array(c(8,2,0))
img1 <- abind(col1, col2, col3, along=2)
img1 <- as.cimg(img1)

c11 <- array(c(5,4,3))
c12 <- array(c(2,2,1))
c13 <- array(c(8,2,0))
C1 <- abind(c11, c12, c13, along=2)

c21 <- array(c(1,2,3))
c22 <- array(c(4,5,6))
c23 <- array(c(7,8,9))
C2 <- abind(c21, c22, c23, along=2)

c31 <- array(c(0,1,0))
c32 <- array(c(0,1,0))
c33 <- array(c(1,10,0))
C3 <- abind(c31, c32, c33, along=2)

img2 <- abind(C1, C2, C3, along=3)
img2 <- as.cimg(img2)

# Test 2D images for all pooling algorithms
testthat::test_that("Max pooling algorithm is failing on greyscale image.", {
    testthat::expect_equal(compression_perrrfect(img1, kernel_size=1, pooling_function="max"), img1)
    testthat::expect_equal(compression_perrrfect(img1, kernel_size=2, pooling_function="max"), as.cimg(5))
    testthat::expect_equal(compression_perrrfect(img1, kernel_size=3, pooling_function="max"), as.cimg(8))
})

testthat::test_that("Min pooling algorithm is failing on greyscale image.", {
    testthat::expect_equal(compression_perrrfect(img1, kernel_size=1, pooling_function="min"), img1)
    testthat::expect_equal(compression_perrrfect(img1, kernel_size=2, pooling_function="min"), as.cimg(2))
    testthat::expect_equal(compression_perrrfect(img1, kernel_size=3, pooling_function="min"), as.cimg(0))
})

testthat::test_that("Mean pooling algorithm is failing on greyscale image.", {
    testthat::expect_equal(compression_perrrfect(img1, kernel_size=1, pooling_function="mean"), img1)
    testthat::expect_equal(compression_perrrfect(img1, kernel_size=2, pooling_function="mean"), as.cimg(3.25))
    testthat::expect_equal(compression_perrrfect(img1, kernel_size=3, pooling_function="mean"), as.cimg(3))
})

# Test 3D images for all pooling algorithms
testthat::test_that("Max pooling algorithm is failing on colour image.", {
    testthat::expect_equal(sum(compression_perrrfect(img2, kernel_size=1, pooling_function='max')==img2), 27)
    testthat::expect_equal(as.vector(compression_perrrfect(img2, kernel_size=2, pooling_function='max')), c(5,5,1))
    testthat::expect_equal(as.vector(compression_perrrfect(img2, kernel_size=3, pooling_function='max')), c(8,9,10))
})

testthat::test_that("Min pooling algorithm is failing on colour image.", {
    testthat::expect_equal(sum(compression_perrrfect(img2, kernel_size=1, pooling_function='min')==img2), 27)
    testthat::expect_equal(as.vector(compression_perrrfect(img2, kernel_size=2, pooling_function='min')), c(2,1,0))
    testthat::expect_equal(as.vector(compression_perrrfect(img2, kernel_size=3, pooling_function='min')), c(0,1,0))
})

testthat::test_that("Mean pooling algorithm is failing on colour image.", {
    testthat::expect_equal(sum(compression_perrrfect(img2, kernel_size=1,
                                                     pooling_function='mean')==img2), 27)
    testthat::expect_equal(as.vector(compression_perrrfect(img2, kernel_size=2,
                                                           pooling_function='mean')), c(3.25,3,0.5))
    testthat::expect_equal(round(as.vector(compression_perrrfect(img2,kernel_size=3,
                                                                 pooling_function='mean')),2), c(3,5,1.44))
})

# Test pooling_function argument
testthat::test_that("Function should stop if 'max', 'min', or 'mean' is not passed in for pooling_function.", {
    testthat::expect_error(compression_perrrfect(img1, kernel_size=1, pooling_function="test"))
})

# Test kernel_size argument
testthat::test_that("Function should stop if kernel_size is not a positive whole number.", {
    testthat::expect_error(compression_perrrfect(img1, kernel_size=10000, pooling_function="max"))
    testthat::expect_error(compression_perrrfect(img1, kernel_size=0, pooling_function="max"))
    testthat::expect_error(compression_perrrfect(img1, kernel_size=-1, pooling_function="max"))
    testthat::expect_error(compression_perrrfect(img1, kernel_size=1.2, pooling_function="max"))
    testthat::expect_error(compression_perrrfect(img1, kernel_size='2', pooling_function="max"))
})

# Test image argument
testthat::test_that("Function should stop if img is not a cimg object.", {
    testthat::expect_error(compression_perrrfect(img1[,,,1], kernel_size=2, pooling_function="max"))
    testthat::expect_error(compression_perrrfect(2, kernel_size=2, pooling_function="max"))
})
