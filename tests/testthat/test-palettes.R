# Embedded palette values.

test_that("category base light has six named hex colours without other", {
  p <- whopals::pal_category("base", "light", include_other = FALSE)
  expect_identical(names(p), as.character(0:5))
  expect_true(all(grepl("^#[0-9A-Fa-f]{6}$", p)))
  expect_identical(p[["4"]], "#008dc9")
})

test_that("category base light includes 99 from embedded tokens", {
  p <- whopals::pal_category("base", "light", include_other = TRUE)
  expect_identical(names(p), c(as.character(0:5), "99"))
  expect_identical(p[["99"]], "#cccccc")
})

test_that("category base dark other matches embedded 99", {
  p <- whopals::pal_category("base", "dark", include_other = TRUE)
  expect_identical(p[["99"]], "#696c85")
})

test_that("theme light includes brand base", {
  t <- whopals::pal_theme("light")
  expect_true("brand.base" %in% names(t))
  expect_identical(t[["brand.base"]], "#008dc9")
})

test_that("sequential brand full light first stop is unchanged", {
  s <- whopals::pal_sequential("brand", "full", "light")
  expect_identical(s[[1]], "#d7e6f3")
})
