
<!-- README.md is generated from README.Rmd. Please edit that file -->

# pictureperrrfect

<!-- badges: start -->
[![R-CMD-check](https://github.com/UBC-MDS/pictureperrrfect/workflows/R-CMD-check/badge.svg)](https://github.com/UBC-MDS/pictureperrrfect/actions)
[![test-coverage](https://github.com/UBC-MDS/pictureperrrfect/workflows/test-coverage/badge.svg)](https://github.com/UBC-MDS/pictureperrrfect/actions)
[![codecov](https://codecov.io/gh/UBC-MDS/pictureperrrfect/branch/master/graph/badge.svg?token=WR0X23ATWK)](https://codecov.io/gh/UBC-MDS/pictureperrrfect)
<!-- badges: end -->

A fun R utility package to make your pictures perfect! The package
enables users to process, manipulate, and gather data about their
images.

## Installation

You can install the released version of pictureperrrfect using the following commands from your Rstudio console:

``` r
# install devtools if needed
install.packages("devtools")

# install pictureperrrfect from this github repo
devtools::install_github("UBC-MDS/pictureperrrfect")
```

## Features

The package pictureperrrfect is an image untility package intended to
manipulate images through a variety of functions. The intention is that
a user with little to no experience can quickly call a function to
alter, compress, or print out statistics for an image. Internally, the
functions make use of matrix operations for quick and efficient
processes.

There are four main functions planned for development and they are
outlined below. Each function can be called on colour images or
greyscale images. Additional functions may be added if time permits.

-   Function 1 filter\_perrrfect: With this function, a user can either
    select a predefined filter or create their own custom filter. The
    image is then passed through the filter and output for the user to
    view.

-   Function 2 get\_property\_perrrfect: The goal of this function is to
    take an image and return statistics related to the different colour
    bands within the image. These statistics include mean and median
    values for each channel as well as a plotted histogram of values for
    each channel.

-   Function 3 compression\_perrrfect: Using a pooling algorithm, this
    function will apply lossy compression to given image. The user will
    be able to specify the type of pooling (max, min, or mean) as well
    as the kernel size.

-   Function 4 rotate\_perrrfect: This final function applies a rotation
    to a given image and outputs the result. A user can specifiy the
    number of degrees they wish the image to be rotated.

Image processing is very popular in the R ecosystem so we are aware that
we are not reinventing the wheel with our package, but we hope to gain a
deeper understanding of the inner workings of an image package.
Specifically, the “imager” library has functions that rotate, flip an
image, or filter which covers 3 of our 4 functions.

## Dependencies

-   R
-   imager

## Usage

-   TODO

## Documentation

-   TODO

## Contributors

We welcome and recognize all contributions. You can find our
contribution guidelines [here](.github/CONTRIBUTING.md).

-   Chad Neald: @ChadNeald
-   Debananda Sarkar: @debanandasarkar
-   Dustin Burnham: @dusty736
-   Kangbo Lu: @KangboLu

### Workflow

For this project we will be using the GitHub Flow strategy for
collaboration.

### Credits

This package was created following along to “R packages” Chapter 2: The
Whole Game by Hadley Wickham and Jenny Bryan.
