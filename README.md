
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ffcbs

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![CRAN
status](https://www.r-pkg.org/badges/version/ffcbs)](https://CRAN.R-project.org/package=ffcbs)
<!-- badges: end -->

The goal of ffcbs is to get CBS fantasy football projections.

## Installation

You can install the released version of ffcbs from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("ffcbs")
```

## Example

This is a basic example which shows you how to get projections for week
0 (the preseason).

``` r
library(ffcbs)

df <- ffcbs_projections(2020, 0, "QB")
df
#> # A tibble: 73 x 16
#>    Player `gp\n          … `att\n         … `cmp\n         … `yds\n         …
#>    <chr>             <int>            <int>            <int>            <int>
#>  1 "L. J…               16              467              299             3521
#>  2 "P. M…               16              559              362             4499
#>  3 "D. P…               16              579              382             4702
#>  4 "D. W…               16              517              346             4079
#>  5 "J. A…               16              541              310             3555
#>  6 "R. W…               16              478              321             3953
#>  7 "T. B…               16              542              336             4497
#>  8 "K. M…               16              559              364             3801
#>  9 "M. R…               16              643              431             4783
#> 10 "D. B…               16              517              367             3828
#> # … with 63 more rows, and 11 more variables: `yds/g\n \n \n \n Passing Yards
#> #   Per Game` <dbl>, `td\n \n \n \n Touchdowns Passes` <int>, `int\n \n \n \n
#> #   Interceptions Thrown` <int>, `rate\n \n \n \n Passer Rating` <chr>, `att\n
#> #   \n \n \n Rushing Attempts` <int>, `yds\n \n \n \n Rushing Yards` <int>,
#> #   `avg\n \n \n \n Average Yards Per Rush` <dbl>, `td\n \n \n \n Rushing
#> #   Touchdowns` <int>, `fl\n \n \n \n Fumbles Lost` <int>, `fpts\n \n \n \n
#> #   Fantasy Points` <int>, `fppg\n \n \n \n Fantasy Points Per Game` <dbl>
```
