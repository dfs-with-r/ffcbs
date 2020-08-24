#' CBS Sports Fantasy Football API
#'
#' @param path path to pull
#' @param query query parameters
#' @export
ffcbs_api <- function(path, query = NULL) {
  # url
  baseurl <- "https://www.cbssports.com/"
  path <- paste0("fantasy/football/stats/", path)
  url <- httr::modify_url(baseurl, path = path, query = query)

    # get data
  resp <- httr::GET(url)

  # get content
  page <- httr::content(resp, "text", encoding = "utf-8")

  # check errors
  if (httr::http_error(resp)) {
    stop(
      sprintf(
        "CBS API request failed [%s]\n[%s]",
        httr::status_code(resp), url
      ),
      call. = FALSE
    )
  }

  # check data type
  if (httr::http_type(resp) != "text/html") {
    stop("API did not return html", call. = FALSE)
  }

  # parse content
  x <- xml2::read_html(page)

  # return S3 object
  class(x) <- c("ffcbs", class(x))
  x
}

