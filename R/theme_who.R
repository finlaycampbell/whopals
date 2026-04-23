# ggplot2 themes from WHO data design language tokens (see README examples).

#' @importFrom systemfonts system_fonts
NULL

# Whether a "Noto Sans" face is registered for use with grid graphics.
# @noRd
.noto_sans_discoverable <- function() {
  if (!requireNamespace("systemfonts", quietly = TRUE)) {
    return(FALSE)
  }
  tab <- tryCatch(
    systemfonts::system_fonts(),
    error = function(e) NULL
  )
  if (is.null(tab) || !"family" %in% names(tab) || nrow(tab) == 0L) {
    return(FALSE)
  }
  fam <- unique(tab$family[!is.na(tab$family)])
  return(any(tolower(trimws(fam)) == "noto sans", na.rm = TRUE))
}

# Use Noto Sans only when requested and discoverable; pass other names through.
# @noRd
.resolve_theme_base_family <- function(base_family) {
  if (is.null(base_family)) {
    return(NULL)
  }
  req <- trimws(base_family)
  if (!nzchar(req)) {
    return(NULL)
  }
  if (tolower(req) != "noto sans") {
    return(req)
  }
  if (.noto_sans_discoverable()) {
    return("Noto Sans")
  }
  return(NULL)
}

# Build one complete WHO theme for a given light/dark branch.
# @param theme `"light"` or `"dark"`.
# @param base_size Base font size passed to [ggplot2::theme_minimal()].
# @param base_family Resolved primary font family (`NULL` = ggplot default).
# @return A [ggplot2::theme()] object.
# @noRd
.theme_who <- function(theme, base_size = 12, base_family = NULL) {
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
    color = pal_foreground("weakest", theme),
    linetype = 3,
    linewidth = ggplot2::rel(0.75)
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
      panel.border = ggplot2::element_blank(),
      strip.background = background,
      axis.ticks = wline,
      axis.line.x.bottom = line,
      axis.line.y = dline,
      panel.grid.major = dline,
      panel.grid.minor = ggplot2::element_blank()
    )
}

#' WHO ggplot2 theme (light)
#'
#' ggplot2 theme using WHO palette tokens. The default **`base_family`**
#' requests **Noto Sans** only when that family is **discoverable** on the
#' system (via [systemfonts::system_fonts()]); otherwise the usual ggplot
#' default sans font is used. Pass any other **`base_family`** string to force
#' a font by name.
#'
#' @param base_size Base font size in pt.
#' @param base_family Primary font family; default `"Noto Sans"` when
#'   installed, else ggplot default (`NULL` behaviour from [ggplot2::theme_minimal()]).
#' @return A [ggplot2::theme()] object.
#' @export
theme_who_light <- function(base_size = 12, base_family = "Noto Sans") {
  fam <- .resolve_theme_base_family(base_family)
  .theme_who("light", base_size = base_size, base_family = fam)
}

#' @describeIn theme_who_light Same styling for the dark token branch.
#' @export
theme_who_dark <- function(base_size = 12, base_family = "Noto Sans") {
  fam <- .resolve_theme_base_family(base_family)
  .theme_who("dark", base_size = base_size, base_family = fam)
}
