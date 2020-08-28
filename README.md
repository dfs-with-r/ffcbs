
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
#> # A tibble: 73 x 19
#>    id    player pos   team  games_played pass_attempts pass_completions
#>    <chr> <chr>  <chr> <chr>        <int>         <int>            <int>
#>  1 2181… Lamar… QB    BAL             16           468              300
#>  2 2142… Patri… QB    KC              16           560              363
#>  3 1824… Dak P… QB    DAL             16           580              383
#>  4 2133… Desha… QB    HOU             16           517              346
#>  5 2181… Josh … QB    BUF             16           541              310
#>  6 1272… Russe… QB    SEA             16           479              322
#>  7 1877… Tom B… QB    TB              16           542              336
#>  8 2180… Kyler… QB    ARI             16           559              364
#>  9 4200… Matt … QB    ATL             16           642              431
#> 10 2351… Drew … QB    NO              16           517              367
#> # … with 63 more rows, and 12 more variables: passing_yards <int>,
#> #   passing_yards_per_game <dbl>, touchdowns_passes <int>,
#> #   interceptions_thrown <int>, passer_rating <chr>, rushing_attempts <int>,
#> #   rushing_yards <int>, average_yards_per_rush <dbl>,
#> #   rushing_touchdowns <int>, fumbles_lost <int>, fantasy_points <int>,
#> #   fantasy_points_per_game <dbl>
```
