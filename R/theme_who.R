# ggplot2 themes from WHO data design language tokens (see README examples).

# Build one complete WHO theme for a given light/dark branch.
# @param theme `"light"` or `"dark"`.
# @param base_size Base font size passed to [ggplot2::theme_minimal()].
# @param base_family Regular-weight (400) family; default `"Noto Sans"`.
# @param semibold_family Family for weight 600; default `"<base_family>
#   SemiBold"` (e.g. `"Noto Sans SemiBold"`).
# @return A [ggplot2::theme()] object.
# @noRd
.theme_who <- function(theme, base_size = 12, base_family = "Noto Sans") {
  theme <- match.arg(theme, c("light", "dark"))

  text <- ggplot2::element_text(color = pal_text("base", theme))
  btext <- ggplot2::element_text(face = "bold", color = pal_text("base", theme))

  background <- ggplot2::element_rect(
    fill = pal_background("base", theme),
    color = NA
  )

  line <- ggplot2::element_line(color = pal_foreground("weaker", theme))
  wline <- ggplot2::element_line(color = pal_foreground("weakest", theme))
  dline <- ggplot2::element_line(
    color = pal_foreground("weaker", theme),
    linetype = 3,
    linewidth = 0.05
  )

  ggplot2::theme_minimal(base_size = base_size, base_family = base_family) +
    ggplot2::theme(
      text = text,
      plot.title = btext,
      axis.text = text,
      strip.text = text,
      legend.text = text,
      legend.title = text,
      plot.background = background,
      panel.background = background,
      panel.border = element_rect(
        color = pal_foreground("weaker", theme),
        linetype = 3,
        linewidth = 0.05
      ),
      strip.background = background,
      axis.ticks = wline,
      axis.line.x.bottom = line,
      axis.line.y = element_blank(),
      panel.grid.major = dline,
      panel.grid.minor = ggplot2::element_blank()
    )
}

#' WHO ggplot2 themes (light / dark)
#'
#' ggplot2 themes using WHO palette tokens and Noto Sans.
#'
#' @rdname theme_who
#' @param base_size Base font size in pt.
#' @param base_family Primary font family (default `"Noto Sans"`).
#' @return A [ggplot2::theme()] object.
#' @export
theme_who_light <- function(base_size = 12, base_family = "Noto Sans") {
  .theme_who("light", base_size = base_size, base_family = base_family)
}

#' @rdname theme_who
#' @export
theme_who_dark <- function(base_size = 12, base_family = "Noto Sans") {
  .theme_who("dark", base_size = base_size, base_family = base_family)
}

#' @rdname theme_who
#' @param theme Either `"light"` or `"dark"`.
#' @export
theme_who <- function(theme = c("light", "dark"),
                      base_size = 12,
                      base_family = "Noto Sans") {
  theme <- match.arg(theme)
  .theme_who(theme, base_size = base_size, base_family = base_family)
}
