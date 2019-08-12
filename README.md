
<!-- README.md is generated from README.Rmd. Please edit that file -->

# matlaber

<!-- badges: start -->

<!-- badges: end -->

The goal of matlaber is to provide an interface to Matlab from R. Matlab
has to be install locally in order for {matlaber} to work.

## Usage

``` r
library(matlaber)

run_matlab("matlabroot")
#> ans = 'C:\ProgramFiles\MATLAB\R2018b'

run_matlab("A = 1")
#> A = 1

# Or in an unquoted environment
run_matlab(code_env({A = 1; B = 2}))
#> A = 1
#> B = 2
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
