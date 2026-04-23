# Save ggplot2 figures with ragg (raster) or Cairo (vector PDF).

# Default width: A4 page (21 cm) minus Word default left and right margins
# (2.54 cm each), i.e. body text column width.
# @noRd
.word_body_width_cm <- function() {
  return(21 - 2 * 2.54)
}

#' Save a ggplot to a file (raster or PDF)
#'
#' Raster formats use the **ragg** devices ([ragg::agg_png()], [ragg::agg_jpeg()],
#' [ragg::agg_tiff()], [ragg::agg_ppm()], [ragg::agg_webp()]). PDF uses
#' [grDevices::cairo_pdf()] for vector output with font embedding when supported
#' by the system.
#'
#' The default **`width_cm`** is the **A4 body text width** with Microsoft Word
#' default margins (2.54 cm left and right): \eqn{21 - 2 \times 2.54 \approx 15.9}{}
#' cm.
#'
#' @param plot A **ggplot** object.
#' @param filename Output path; format is chosen from the file extension
#'   (case-insensitive): `.pdf`, `.png`, `.jpg`/`.jpeg`, `.tif`/`.tiff`,
#'   `.ppm`, `.webp`.
#' @param width_cm Plot width in centimetres. Defaults to the A4 body text
#'   width with Word default 2.54 cm left and right margins
#'   (\eqn{21 - 2 \times 2.54}{} cm, i.e. about 15.9 cm).
#' @param height_cm Plot height in centimetres. If `NULL` (default), uses
#'   `width_cm * 0.65`.
#' @param dpi Resolution for **raster** formats only (PDF ignores `dpi`).
#' @param ... Additional arguments passed to the graphics device (e.g.
#'   `background` for ragg).
#' @return `filename` invisibly.
#' @export
save_plot <- function(plot, filename, width_cm = .word_body_width_cm(),
                      height_cm = NULL, dpi = 300, ...) {
  if (!inherits(plot, "ggplot")) {
    stop("`plot` must be a ggplot object.", call. = FALSE)
  }
  if (length(filename) != 1L || !nzchar(filename)) {
    stop("`filename` must be a single non-empty path.", call. = FALSE)
  }
  height_cm <- if (is.null(height_cm)) {
    width_cm * 0.65
  } else {
    height_cm
  }
  ext <- tolower(tools::file_ext(filename))
  if (!nzchar(ext)) {
    stop(
      "`filename` must include an extension (e.g. .pdf, .png).",
      call. = FALSE
    )
  }
  device <- switch(
    ext,
    pdf = grDevices::cairo_pdf,
    png = ragg::agg_png,
    jpg = ragg::agg_jpeg,
    jpeg = ragg::agg_jpeg,
    tif = ragg::agg_tiff,
    tiff = ragg::agg_tiff,
    ppm = ragg::agg_ppm,
    webp = ragg::agg_webp,
    NULL
  )
  if (is.null(device)) {
    stop(
      "Unsupported extension `.", ext, "`. ",
      "Use pdf, png, jpg, jpeg, tif, tiff, ppm, or webp.",
      call. = FALSE
    )
  }
  ggplot2::ggsave(
    filename = filename,
    plot = plot,
    width = width_cm,
    height = height_cm,
    units = "cm",
    dpi = dpi,
    device = device,
    ...
  )
  invisible(filename)
}
