
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

You can install the development version of ffcbs from github with:

``` r
remotes::install_github("dfs-with-r/ffcbs")
```

## Example

This is a basic example which shows you how to get projections for week
0 (the preseason).

``` r
library(ffcbs)

df <- ffcbs_projections(2020, 0, "QB")
df
#> # A tibble: 73 x 18
#>    Player Pos   Team  `Games Played` `Pass Attempts` `Pass Completio…
#>    <chr>  <chr> <chr>          <int>           <int>            <int>
#>  1 Lamar… QB    BAL               16             467              299
#>  2 Patri… QB    KC                16             559              362
#>  3 Dak P… QB    DAL               16             579              382
#>  4 Desha… QB    HOU               16             517              346
#>  5 Josh … QB    BUF               16             541              310
#>  6 Russe… QB    SEA               16             478              321
#>  7 Tom B… QB    TB                16             542              336
#>  8 Kyler… QB    ARI               16             559              364
#>  9 Matt … QB    ATL               16             643              431
#> 10 Drew … QB    NO                16             517              367
#> # … with 63 more rows, and 12 more variables: `Passing Yards` <int>, `Passing
#> #   Yards Per Game` <dbl>, `Touchdowns Passes` <int>, `Interceptions
#> #   Thrown` <int>, `Passer Rating` <chr>, `Rushing Attempts` <int>, `Rushing
#> #   Yards` <int>, `Average Yards Per Rush` <dbl>, `Rushing Touchdowns` <int>,
#> #   `Fumbles Lost` <int>, `Fantasy Points` <int>, `Fantasy Points Per
#> #   Game` <dbl>
```
