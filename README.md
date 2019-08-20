
<!-- README.md is generated from README.Rmd. Please edit that file -->

# matlaber

<!-- badges: start -->

<!-- badges: end -->

The goal of matlaber is to provide an interface to Matlab from R. Matlab
has to be install locally in order for {matlaber} to work.

## Usage

``` r
library(matlaber)
#> Registered S3 method overwritten by 'R.oo':
#>   method        from       
#>   throw.default R.methodsS3

mat_run("matlabroot")
#> 
#> --- stdout:
#> 
#> ans =
#> 
#>     'C:\Program Files\MATLAB\R2018b'

mat_run("A = 1")
#> 
#> --- stdout:
#> 
#> A =
#> 
#>      1
```

## Feedback Needed

What do you need an interface to matlab for ? Feel free to get in
touch\!

## Installation

``` r
devtools::install_github("matlaber")
```

-----

Please note that the ‘matlaber’ project is released with a [Contributor
Code of Conduct](.github/CODE_OF_CONDUCT.md). By contributing to this
project, you agree to abide by its terms.
