qb_untidy <- readRDS("untidy-qb-projections.rds")

test_that("tidy projections", {
  df_tidy <- tidy_projections(qb_untidy, "QB")

  expect_identical(nrow(df_tidy), 73L)
  expect_identical(ncol(df_tidy), 18L)
  expect_true(all(df_tidy$pos == "QB"))
  expect_identical(colnames(df_tidy)[1:3], c("player", "pos", "team"))
})
