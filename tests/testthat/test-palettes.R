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

test_that("pal_theme single component returns one named hex", {
  t <- whopals::pal_theme("brand", "base", "light")
  expect_identical(names(t), "brand.base")
  expect_identical(unname(t), "#008dc9")
})

test_that("pal_theme all brand components light match embedded tokens", {
  t <- whopals::pal_theme("brand", theme = "light")
  expect_setequal(
    names(t),
    c("brand.base", "brand.stronger", "brand.weaker")
  )
  expect_identical(t[["brand.base"]], "#008dc9")
})

test_that("pal_selection base light includes stroke and slot names", {
  s <- whopals::pal_selection("base", "light")
  expect_true("stroke" %in% names(s))
  expect_true("0.base" %in% names(s))
  expect_identical(s[["stroke"]], "#1a1a1a")
  expect_identical(s[["default.base"]], "#008dc9")
})

test_that("pal_selection stronger dark default matches embedded", {
  s <- whopals::pal_selection("stronger", "dark")
  expect_identical(s[["default.stronger"]], "#25b3ef")
})

test_that("sequential brand base light first stop is unchanged", {
  s <- whopals::pal_sequential("brand", "base", "light")
  expect_identical(s[[1]], "#d7e6f3")
})

test_that("sequential brand secondary drops lightest stop", {
  full <- whopals::pal_sequential("brand", "base", "light")
  sec <- whopals::pal_sequential("brand", "secondary", "light")
  expect_length(sec, length(full) - 1L)
  expect_identical(sec, full[-1L])
})

test_that("sequential colorful base and alt differ", {
  b <- whopals::pal_sequential("colorful", "base", "light")
  a <- whopals::pal_sequential("colorful", "alt", "light")
  expect_false(identical(b, a))
  expect_identical(b[[1]], "#fbf6ca")
  expect_identical(a[[1]], "#fbf6ca")
  expect_false(identical(b[[5]], a[[5]]))
})
