# Regenerate R/colors.R from inst/colors.json.
# Run from the package root:
#   Rscript data-raw/build_whopals_colors.R
# or: source("data-raw/build_whopals_colors.R", chdir = TRUE) after setwd()

args <- commandArgs(trailingOnly = FALSE)
file_arg <- grep("^--file=", args, value = TRUE)
script_path <- if (length(file_arg)) {
  normalizePath(sub("^--file=", "", file_arg[[1L]]), winslash = "/",
                  mustWork = TRUE)
} else {
  NA_character_
}
pkg_root <- if (!is.na(script_path)) {
  dirname(dirname(script_path))
} else {
  normalizePath(file.path(getwd(), ".."), winslash = "/", mustWork = TRUE)
}

json_path <- file.path(pkg_root, "inst", "colors.json")
if (!file.exists(json_path)) {
  stop("Missing: ", json_path, call. = FALSE)
}

if (!requireNamespace("jsonlite", quietly = TRUE)) {
  stop("Install jsonlite to run this script.", call. = FALSE)
}

tok <- jsonlite::fromJSON(json_path, simplifyVector = FALSE)
color <- tok[["color"]]
if (is.null(color)) {
  stop("JSON missing top-level `color`", call. = FALSE)
}

# Category 99 ("other") is in the WHO design language public spec but often
# absent from colors.json; merge it into category base/stronger/text.
inject_category_other_99 <- function(col) {
  other_hex <- c(light = "#cccccc", dark = "#696c85")
  for (th in names(other_hex)) {
    if (is.null(col[[th]]) || is.null(col[[th]][["category"]])) {
      next
    }
    o99 <- other_hex[[th]]
    for (st in c("base", "stronger", "text")) {
      blk <- col[[th]][["category"]][[st]]
      if (!is.null(blk) && is.list(blk)) {
        col[[th]][["category"]][[st]][["99"]] <- o99
      }
    }
  }
  col
}
color <- inject_category_other_99(color)

out_path <- file.path(pkg_root, "R", "colors.R")
hdr <- c(
  "#' WHO data design language embedded colour list (internal).",
  "#'",
  "#' Source of truth for regeneration: inst/colors.json",
  "#' Spec: https://srhdteuwpubsa.z6.web.core.windows.net/gho/data/design-language/design-system/colors/",
  "#'",
  "#' Do not edit by hand unless syncing with the JSON; otherwise run:",
  "#' `Rscript data-raw/build_whopals_colors.R`",
  "#'",
  "#' @keywords internal",
  "#' @noRd",
  NULL
)
hdr <- hdr[!vapply(hdr, is.null, logical(1L))]

e <- new.env(parent = emptyenv())
e[[".whopals_colors"]] <- color
tmp <- tempfile(fileext = ".R")
on.exit(unlink(tmp), add = TRUE)
dump(".whopals_colors", file = tmp, envir = e)
body <- readLines(tmp, warn = FALSE)
body <- body[!grepl("^NULL$", body)]
writeLines(c(hdr, body), out_path, useBytes = TRUE)
message("Wrote ", out_path)
