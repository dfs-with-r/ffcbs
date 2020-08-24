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
  return(df)
  tidy_projections(df, pos)
}

#' Tidy projections
#'
#' @param x data frame of projections
#' @param pos position
#'
#' @keywords internal
tidy_projections <- function(x, pos) {
  # clean column names
  x <- dplyr::rename_all(x, ~ stringr::str_remove_all(.x, "\\n"))
  x <- dplyr::rename_all(x, ~ stringr::str_remove(.x, "[a-z/]+ "))
  x <- dplyr::rename_all(x, stringr::str_trim)

  # clean player names
  is_dst <- pos == "DST"

  if (!is_dst) {
    player_attr <- stringr::str_match_all(x$Player, "([A-Za-z'-.]+\\s[A-Za-z'-.]+)\\s+([A-Z]+)\\s+([A-Z]+)")
    x$Player <- vapply(player_attr, function(p) p[nrow(p),2], FUN.VALUE = character(1L))
    x$Team <- vapply(player_attr, function(p) p[nrow(p),4], FUN.VALUE = character(1L))
  } else {
    x$Player <- x$Team
  }

  x$Pos <- pos


  # re-order columns
  dplyr::select(x, "Player", "Pos", "Team", dplyr::everything())
}
