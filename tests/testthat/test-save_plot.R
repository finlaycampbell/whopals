# save_plot().

test_that("save_plot rejects non-ggplot and bad extension", {
  expect_error(whopals::save_plot(1L, "x.png"), "ggplot")
  expect_error(whopals::save_plot(ggplot2::ggplot(), "nope"), "extension")
})

test_that("save_plot writes png", {
  skip_if_not_installed("ggplot2")
  skip_if_not_installed("ragg")
  p <- ggplot2::ggplot(data.frame(x = 1), ggplot2::aes(x, x)) +
    ggplot2::geom_point() +
    whopals::theme_who_dark()
  dir <- tempfile("saveplot")
  dir.create(dir)
  on.exit(unlink(dir, recursive = TRUE), add = TRUE)
  f1 <- file.path(dir, "a.png")
  expect_identical(whopals::save_plot(p, f1), f1)
  expect_true(file.exists(f1))
})

test_that("save_plot writes pdf with cairo_pdf", {
  skip_if_not_installed("ggplot2")
  skip_if_not_installed("ragg")
  # grDevices::cairo_pdf + ggsave can segfault on GitHub Actions macOS
  # (e.g. aarch64-apple-darwin); PNG via ragg is fine on the same runners.
  skip_if(
    nzchar(Sys.getenv("CI", "")) &&
      grepl("darwin", R.version$os, ignore.case = TRUE),
    "cairo_pdf unstable on macOS CI"
  )
  p <- ggplot2::ggplot(data.frame(x = 1), ggplot2::aes(x, x)) +
    ggplot2::geom_point() +
    whopals::theme_who_dark()
  dir <- tempfile("saveplot")
  dir.create(dir)
  on.exit(unlink(dir, recursive = TRUE), add = TRUE)
  f2 <- file.path(dir, "b.pdf")
  whopals::save_plot(p, f2, width_cm = 10, height_cm = 8)
  expect_true(file.exists(f2))
})
