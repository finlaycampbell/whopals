# WHO data design language colour palettes from design tokens.
# Spec:
# https://srhdteuwpubsa.z6.web.core.windows.net/gho/data/design-language/design-system/colors/
# Colours are embedded in `.whopals_colors` (see `R/colors.R`),
# regenerated from `inst/colors.json` via
# `data-raw/build_whopals_colors.R`. Optional `n` uses CIELAB interpolation
# between token stops (see design language site).

# Light or dark subtree of `.whopals_colors` (brand, category, …).
# @noRd
.whopals_theme_colors <- function(theme) {
  out <- .whopals_colors[[theme]]
  if (is.null(out)) {
    stop(
      ".whopals_colors missing `", theme, "` branch.",
      call. = FALSE
    )
  }
  return(out)
}

#' Flatten a nested token branch into a named character vector of hex colours
#'
#' Names use dot-separated paths (e.g. `category.base.0`).
#'
#' @param x A list whose leaves are hex strings.
#' @param prefix Used during recursion; leave at default when calling.
#' @return Named character vector of `#RRGGBB` values.
#' @keywords internal
#' @noRd
.flatten_color_branch <- function(x, prefix = character()) {
  if (is.null(x)) {
    return(character())
  }
  if (is.character(x) && length(x) == 1L && grepl("^#[0-9A-Fa-f]{6}$", x)) {
    nm <- paste(prefix, collapse = ".")
    return(stats::setNames(x, nm))
  }
  if (!is.list(x)) {
    return(character())
  }
  pieces <- lapply(names(x), function(nm) {
    .flatten_color_branch(x[[nm]], c(prefix, nm))
  })
  unlist(pieces, use.names = TRUE)
}

#' Interpolate colours in CIELAB space between control stops
#'
#' Uses [grDevices::colorRampPalette()] with `space = "Lab"` (R >= 4.0).
#'
#' @param stops Character vector of hex colours, low to high.
#' @param n Target length.
#' @return Character vector of length `n`.
#' @keywords internal
#' @noRd
.interp_hex_lab <- function(stops, n) {
  if (length(stops) < 2L) {
    stop("Need at least two stops to interpolate.", call. = FALSE)
  }
  grDevices::colorRampPalette(stops, space = "Lab")(n)
}

#' Ordered stops from a named list with numeric-ish keys
#'
#' @param lst A list with keys "0", "1", ...
#' @return Character vector in increasing key order.
#' @keywords internal
#' @noRd
.ordered_stops <- function(lst) {
  if (is.null(lst) || !is.list(lst)) {
    stop("Expected a non-NULL list of colour stops.", call. = FALSE)
  }
  nm <- names(lst)
  if (is.null(nm)) {
    return(unlist(lst, use.names = FALSE))
  }
  ord <- order(as.integer(nm))
  unlist(lst[ord], use.names = TRUE)
}

#' Theme colours (brand, foreground, background, text)
#'
#' Matches the "Color themes" section of the design language. Pick a
#' **`variant`** branch, then either one **`component`** (a single hex) or leave
#' **`component`** unset to return every immediate hex leaf under that branch
#' (names are the token keys only, e.g. `base`, `weaker`, not `brand.base`).
#'
#' @param variant One of `brand`, `foreground`, `background`, `text`.
#' @param component Token key under that variant (`base`, `weaker`, `stronger`,
#'   `weakest`, `selection`, etc., depending on `variant`). If `NULL`, all
#'   immediate hex children under **`variant`** are returned.
#' @param theme Either `"light"` or `"dark"`.
#' @return Named character vector of hex colours.
#' @export
pal_theme <- function(variant = c("brand", "foreground", "background", "text"),
                      component = NULL,
                      theme = c("light", "dark")) {
  variant <- match.arg(variant)
  theme <- match.arg(theme)
  br <- .whopals_theme_colors(theme)
  node <- br[[variant]]
  if (is.null(node)) {
    stop("Unknown variant `", variant, "` for theme ", theme, call. = FALSE)
  }
  if (!is.list(node)) {
    stop("Expected a list of theme tokens for variant `", variant, "`.",
      call. = FALSE
    )
  }
  comp_names <- names(node)
  if (is.null(comp_names)) {
    stop("Variant `", variant, "` has no named components.", call. = FALSE)
  }
  if (is.null(component)) {
    out <- character()
    for (nm in comp_names) {
      val <- node[[nm]]
      if (is.character(val) &&
        length(val) == 1L &&
        grepl("^#[0-9A-Fa-f]{6}$", val)) {
        out <- c(out, stats::setNames(val, nm))
      }
    }
    if (length(out) == 0L) {
      stop("No immediate hex leaves under variant `", variant, "`.",
        call. = FALSE
      )
    }
    return(out)
  }
  component <- match.arg(component, choices = comp_names)
  val <- node[[component]]
  if (!is.character(val) ||
    length(val) != 1L ||
    !grepl("^#[0-9A-Fa-f]{6}$", val)) {
    stop(
      "`", variant, ".", component, "` is not a single hex colour for theme ",
      theme, ".",
      call. = FALSE
    )
  }
  return(stats::setNames(val, component))
}

#' Selection colours (multi-selection slots and stroke)
#'
#' Reads `functional/selection` from the embedded tokens. Each numbered slot
#' and `default` expose **`base`** and **`stronger`**; **`stroke`** is a single
#' hex shared across contexts.
#'
#' @param component Either `base` or `stronger` (applied to list slots that
#'   define both; `stroke` is always included unchanged).
#' @param theme Either `"light"` or `"dark"`.
#' @return Named character vector of hex colours, always in order `0`, `1`,
#'   `2`, `stroke`, `default` (missing keys are skipped).
#' @export
pal_selection <- function(component = c("base", "stronger"),
                          theme = c("light", "dark")) {
  component <- match.arg(component)
  theme <- match.arg(theme)
  sel <- .whopals_theme_colors(theme)[["functional"]][["selection"]]
  if (is.null(sel)) {
    stop("No functional/selection tokens for theme ", theme, call. = FALSE)
  }
  # Stable order for README plots and predictable indexing.
  key_order <- c("0", "1", "2", "stroke", "default")
  out <- character()
  for (nm in key_order) {
    if (!nm %in% names(sel)) {
      next
    }
    el <- sel[[nm]]
    if (is.character(el) &&
      length(el) == 1L &&
      grepl("^#[0-9A-Fa-f]{6}$", el)) {
      out <- c(out, stats::setNames(el, nm))
    } else if (is.list(el)) {
      hx <- el[[component]]
      if (is.null(hx)) {
        stop(
          "Selection `", nm, "` has no `", component, "` for theme ", theme,
          ".",
          call. = FALSE
        )
      }
      if (!is.character(hx) ||
        length(hx) != 1L ||
        !grepl("^#[0-9A-Fa-f]{6}$", hx)) {
        stop("Invalid hex for selection ", nm, ".", component, call. = FALSE)
      }
      out <- c(out, stats::setNames(hx, nm))
    } else {
      stop("Unexpected structure for selection `", nm, "`.", call. = FALSE)
    }
  }
  extra <- setdiff(names(sel), key_order)
  if (length(extra) > 0L) {
    stop(
      "Unexpected selection keys: ", paste(extra, collapse = ", "),
      call. = FALSE
    )
  }
  return(out)
}

#' Nominal category colours (including optional "other")
#'
#' Returns the main six-colour nominal pool (`0` … `5`, optionally `99` for
#' "other") from the design language.
#'
#' @param theme Either `"light"` or `"dark"`.
#' @param component Contrast level: `base`, `stronger`, or `text` branches under
#'   `category` in the embedded tokens.
#' @param include_other If `TRUE`, include category `99` ("other") from the
#'   embedded tokens (`category.<component>$99`, merged at build time from the
#'   WHO design language spec).
#' @return Named character vector `0` … `5`, plus `99` when requested.
#' @export
pal_category <- function(component = c("base", "stronger", "text"),
                         theme = c("light", "dark"),
                         include_other = FALSE) {
  component <- match.arg(component)
  theme <- match.arg(theme)
  cats <- .whopals_theme_colors(theme)[["category"]]
  block <- cats[[component]]
  if (is.null(block)) {
    stop("No category/", component, " for theme ", theme, call. = FALSE)
  }
  out <- unlist(block, use.names = TRUE)
  if (!include_other) {
    return(out[names(out) != "99"])
  }
  return(out)
}

#' WHO region colours (`base` fills or `text` variants)
#'
#' Region `base` colours are read from `category.region`. Region `text`
#' colours follow the public mapping (text tone keyed to the same category
#' index as each region's base hue): AFRO→3, AMRO→1, EMRO→2, EUR→4,
#' SEARO→5, WPRO→0.
#'
#' @param theme Either `"light"` or `"dark"`.
#' @param component `base` (from `category.region`) or `text` (from
#'   `category.text` using the mapping above).
#' @return Named vector with keys `afro`, `amro`, `emro`, `euro`, `searo`,
#'   `wpro`.
#' @export
pal_region <- function(component = c("base", "text"),
                         theme = c("light", "dark")) {
  component <- match.arg(component)
  theme <- match.arg(theme)
  cats <- .whopals_theme_colors(theme)[["category"]]
  if (component == "base") {
    reg <- cats[["region"]]
    if (is.null(reg)) {
      stop("No category.region for theme ", theme, call. = FALSE)
    }
    return(unlist(reg, use.names = TRUE))
  }
  txt <- cats[["text"]]
  if (is.null(txt)) {
    stop("No category.text for theme ", theme, call. = FALSE)
  }
  key <- c(
    afro = "3", amro = "1", emro = "2",
    euro = "4", searo = "5", wpro = "0"
  )
  stats::setNames(
    vapply(key, function(k) txt[[k]], character(1L)),
    names(key)
  )
}

#' Sequential scales (`brand`, `complementary`, `colorful`)
#'
#' Stops match the embedded token keys (low to high). For `brand` and
#' `complementary`, `component = "secondary"` drops the lightest stop (the
#' shorter scales on the design language site). For `colorful`, pick
#' `component = "base"` or `"alt"` (two multi-hue tracks).
#'
#' @param theme Either `"light"` or `"dark"`.
#' @param variant Scale family: `brand`, `complementary`, or `colorful`.
#' @param component For `brand` and `complementary`: `base` (all stops) or
#'   `secondary` (omit the lightest stop). For `colorful`: `base` or `alt`.
#' @param n If `NULL`, return the discrete token stops. If a positive integer,
#'   interpolate in CIELAB space between those stops to length `n`.
#' @return Unnamed (if `n` set) or named character vector of hex colours.
#' @export
pal_sequential <- function(
    variant = c("brand", "complementary", "colorful"),
    component = "base",
    theme = c("light", "dark"),
    n = NULL) {
  variant <- match.arg(variant)
  theme <- match.arg(theme)
  seq_block <- .whopals_theme_colors(theme)[["sequential"]]
  if (variant %in% c("brand", "complementary")) {
    component <- match.arg(component, c("base", "secondary"))
    stops <- .ordered_stops(seq_block[[variant]])
    if (component == "secondary") {
      if (length(stops) < 3L) {
        stop("Not enough stops for secondary component.", call. = FALSE)
      }
      stops <- stops[-1L]
    }
  } else {
    component <- match.arg(component, c("base", "alt"))
    col <- seq_block[["colorful"]][[component]]
    if (is.null(col)) {
      stop("No sequential/colorful/", component, " for theme ", theme,
        call. = FALSE
      )
    }
    stops <- .ordered_stops(col)
  }
  if (is.null(n)) {
    return(stops)
  }
  if (length(n) != 1L || !is.numeric(n) || n < 2L) {
    stop("`n` must be NULL or an integer >= 2.", call. = FALSE)
  }
  n <- as.integer(n)
  .interp_hex_lab(stops, n)
}

#' Diverging scales (`base` or `alt`)
#'
#' Ordered from negative end → neutral → positive end, as on the design
#' language site.
#'
#' @param theme Either `"light"` or `"dark"`.
#' @param component `base` or `alt`, matching token group names under
#'   `diverging/`.
#' @param n If `NULL`, return the five token stops. If an integer >= 2,
#'   interpolate in CIELAB space to length `n`.
#' @return Named vector with keys `negative-2`, `negative-1`, `neutral`,
#'   `positive-1`, `positive-2`, unless `n` is set (then unnamed interpolated
#'   vector).
#' @export
pal_diverging <- function(component = c("base", "alt"),
                          theme = c("light", "dark"),
                          n = NULL) {
  component <- match.arg(component)
  theme <- match.arg(theme)
  div <- .whopals_theme_colors(theme)[["diverging"]][[component]]
  keys <- c("negative-2", "negative-1", "neutral", "positive-1", "positive-2")
  stops <- vapply(keys, function(k) div[[k]], character(1L), USE.NAMES = TRUE)
  if (is.null(n)) {
    return(stops)
  }
  if (length(n) != 1L || !is.numeric(n) || n < 2L) {
    stop("`n` must be NULL or an integer >= 2.", call. = FALSE)
  }
  .interp_hex_lab(stops, as.integer(n))
}

#' Functional colours (accent, focus, not available, …)
#'
#' Flattens all `functional/*` tokens except **`selection`** (use
#' [pal_selection()] for those).
#'
#' @param theme Either `"light"` or `"dark"`.
#' @return Named character vector of flattened `functional/*` hex values.
#' @export
pal_functional <- function(theme = c("light", "dark")) {
  theme <- match.arg(theme)
  fn <- .whopals_theme_colors(theme)[["functional"]]
  fn <- fn[names(fn) != "selection"]
  .flatten_color_branch(fn)
}

#' Gender / sex category colours
#'
#' @param theme Either `"light"` or `"dark"`.
#' @return Named vector `male`, `female`, `misc`.
#' @export
pal_gender <- function(theme = c("light", "dark")) {
  theme <- match.arg(theme)
  g <- .whopals_theme_colors(theme)[["category"]][["gender"]]
  unlist(g, use.names = TRUE)
}

#' Trend category colours (worsening, stagnating, improving, unspecified)
#'
#' @param theme Either `"light"` or `"dark"`.
#' @param component Return `base` mark colours, `text` label colours, or `both`
#'   as a flat list with `*.base` and `*.text` names.
#' @export
pal_trend <- function(component = c("base", "text", "both"),
                      theme = c("light", "dark")) {
  component <- match.arg(component)
  theme <- match.arg(theme)
  tr <- .whopals_theme_colors(theme)[["category"]][["trend"]]
  if (component == "both") {
    return(.flatten_color_branch(tr))
  }
  nm <- names(tr)
  stats::setNames(
    vapply(nm, function(k) tr[[k]][[component]], character(1L)),
    nm
  )
}
