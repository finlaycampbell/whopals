# ggplot2 WHO themes.

test_that("theme_who_light and theme_who_dark return merged themes", {
  tl <- whopals::theme_who_light()
  td <- whopals::theme_who_dark()
  expect_s3_class(tl, "theme")
  expect_s3_class(td, "theme")
})

test_that("WHO theme sets major grid lines and blanks minor grids", {
  tl <- whopals::theme_who_light()
  expect_s3_class(tl$panel.grid.major, "element_line")
  expect_s3_class(tl$panel.grid.minor, "element_blank")
})

test_that("plot and panel fills match background/base tokens", {
  tl <- whopals::theme_who_light()
  td <- whopals::theme_who_dark()
  expect_identical(
    unname(tl$plot.background$fill),
    unname(whopals::pal_background("base", "light"))
  )
  expect_identical(
    unname(tl$panel.background$fill),
    unname(whopals::pal_background("base", "light"))
  )
  expect_identical(
    unname(td$plot.background$fill),
    unname(whopals::pal_background("base", "dark"))
  )
  expect_identical(
    unname(td$panel.background$fill),
    unname(whopals::pal_background("base", "dark"))
  )
})

test_that("default Noto Sans is set on base text", {
  tl <- whopals::theme_who_light()
  expect_identical(tl$text$family, "Noto Sans")
  expect_identical(tl$text$face, "plain")
  expect_identical(tl$plot.title$face, "bold")
})

test_that("theme_who(theme) matches theme_who_light and theme_who_dark", {
  expect_identical(whopals::theme_who("light"), whopals::theme_who_light())
  expect_identical(whopals::theme_who("dark"), whopals::theme_who_dark())
})
