# data-raw

## `build_whopals_colors.R`

When `inst/colors.json` changes (WHO design token release), regenerate the bundled colour list used by the palette functions:

```r
Rscript data-raw/build_whopals_colors.R
```

This overwrites `R/colors.R`. Reload the package and run tests.

The script needs the **jsonlite** package (`install.packages("jsonlite")`); it is not a runtime dependency of **whopals**.

The build step also adds **category 99** (“other”) hex values under `category$base`, `category$stronger`, and `category$text` for each theme (WHO design language spec values not always present in the JSON).
