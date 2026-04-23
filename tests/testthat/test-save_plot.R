# save_plot().

test_that("save_plot rejects non-ggplot and bad extension", {
  expect_error(whopals::save_plot(1L, "x.png"), "ggplot")
  expect_error(whopals::save_plot(ggplot2::ggplot(), "nope"), "extension")
})

test_that("save_plot writes png and pdf", {
  skip_if_not_installed("ggplot2")
  skip_if_not_installed("ragg")
  p <- ggplot2::ggplot(data.frame(x = 1), ggplot2::aes(x, x)) +
    ggplot2::geom_point()
  dir <- tempfile("saveplot")
  dir.create(dir)
  on.exit(unlink(dir, recursive = TRUE), add = TRUE)
  f1 <- file.path(dir, "a.png")
  f2 <- file.path(dir, "b.pdf")
  expect_identical(whopals::save_plot(p, f1), f1)
  expect_true(file.exists(f1))
  whopals::save_plot(p, f2, width_cm = 10, height_cm = 8)
  expect_true(file.exists(f2))
})
