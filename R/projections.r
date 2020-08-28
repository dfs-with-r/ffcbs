#' Projections
#' @param season integer year
#' @param week integer week (0 - 17)
#' @param pos character position
#'
#' @export
ffcbs_projections <- function(season, week, pos = c("QB", "RB", "WR", "TE", "K", "DST")) {
  # validate input
  pos <- match.arg(pos)
  stopifnot(is.numeric(week), is.numeric(season), is.character(pos))
  stopifnot(is_scalar(week), is_scalar(season), is_scalar(pos))
  stopifnot(week >= 0L, week <= 17L)

  # convert input
  week <- as.integer(week)
  season <- as.integer(season)

  # build path
  period <- ifelse(week == 0L, "season", as.character(week))
  path <- sprintf("%s/%s/%s/projections/nonppr", toupper(pos), season, period)

  # GET
  x <- ffcbs_api(path)

  # tidy
  xml2::xml_remove(xml2::xml_find_all(x, "//colgroup"))
  xml2::xml_remove(xml2::xml_find_all(x, "span.CellPlayerName--short"))
  xml2::xml_remove(xml2::xml_find_all(x, "div.Tablebase-tooltip"))
  xml2::xml_remove(xml2::xml_find_all(x, "//tr[@class = 'TableBase-headGroupTr']"))

  # parse table
  x <- xml2::xml_find_all(x, "//table[@class = 'TableBase-table']")
  df <- rvest::html_table(x)[[1]]
  df <- tibble::tibble(df)
  df <- tidy_projections(df, pos)

  # parse ids
  #return(x)
  if (pos != "DST") {
    id_links <- xml2::xml_find_all(x, "//span[1]/span/a[contains(@href, '/fantasy/football/players/')]")
    id_links <- xml2::xml_attr(id_links, "href")
    ids <- stringr::str_match(id_links, "/fantasy/football/players/([0-9]+)/")[,2]
  } else {
    #ids <- df$team
    id_links <- xml2::xml_find_all(x, "//span[2]/span/a[contains(@href, '/nfl/teams')]")
    id_links <- xml2::xml_attr(id_links, "href")
    matches <- stringr::str_match(id_links, "/nfl/teams/([A-Z]{2,3})/([a-z-]+)")
    df$team <- matches[,2]
    ids <- matches[,3]
  }

  # add ids to table
  df$id <- ids
  df <- dplyr::select(df, "id", dplyr::everything())

  # return data frame
  return(df)
}

#' Tidy column names
#'
#' @param x character vector
tidy_colname <- function(x) {
  x <- stringr::str_remove_all(x, "\\n")
  x <- stringr::str_remove(x, "[a-z/]+ ")
  x <- stringr::str_trim(x)
  x <- stringr::str_replace_all(x, " ", "_")
  x <- stringr::str_to_lower(x)
  x
}

#' Tidy projections
#'
#' @param x data frame of projections
#' @param pos position
#'
#' @keywords internal
tidy_projections <- function(x, pos) {
  # clean column names
  x <- dplyr::rename_all(x, tidy_colname)

  # clean player names
  is_dst <- pos == "DST"

  # fix player/team name when player is a defense
  if (!is_dst) {
    player_attr <- stringr::str_match_all(x$player, "([A-Za-z'-.]+\\s[A-Za-z'-.]+)\\s+([A-Z]+)\\s+([A-Z]+)")
    x$player <- purrr::map_chr(player_attr, function(p) p[nrow(p),2])
    x$team <- purrr::map_chr(player_attr, function(p) p[nrow(p),4])
  } else {
    x$player <- x$team
  }

  # add position column
  x$pos <- pos

  # re-order columns
  dplyr::select(x, "player", "pos", "team", dplyr::everything())
}
