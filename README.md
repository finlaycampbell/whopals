
<!-- README.md is generated from README.Rmd. Please edit README.Rmd and run `rmarkdown::render("README.Rmd")`. -->

# whopals

**whopals** turns the colour definitions from the [WHO Data Design
Language —
Colours](https://srhdteuwpubsa.z6.web.core.windows.net/gho/data/design-language/design-system/colors/)
into plain R: named hex vectors and small accessor functions so you can
use the same themes, categories, regions, sequential and diverging
scales, and functional colours in **ggplot2**, **highcharter**, or any
other R graphics without hand-copying values from the site. Values are
embedded from WHO design tokens (see `data-raw/build_whopals_colors.R`
and `R/colors.R`).

## Installation

``` r
pak::pak("finlaycampbell/whopals")
```

After `library(whopals)`, use `whopals::pal_theme()`,
`whopals::pal_category()`, `whopals::pal_region()`,
`whopals::pal_sequential()`, `whopals::pal_diverging()`,
`whopals::pal_functional()`, `whopals::pal_gender()`, and
`whopals::pal_trend()` (the `whopals::` prefix is optional once the
package is attached). **`theme`** is always `light` or `dark` where the
function takes it. **`pal_sequential()`** uses **`variant`** (scale
family; see table) and **`component`** (`base` / `secondary` for brand
and complementary, `base` / `alt` for colorful). **`pal_category()`**
uses **`name`** (see table) and **`component`** (`base`, `stronger`,
`text`). **`pal_region()`**, **`pal_diverging()`**, and
**`pal_trend()`** use **`component`** for their `base` / `text` / `alt`
/ `both` choices (see each function’s documentation). See roxygen help
for **`include_other`**, **`n`**, and defaults.

### `variant` and `name` (not `component` or `theme`)

| Function           | `variant`                            | `name`    |
|--------------------|--------------------------------------|-----------|
| `pal_theme()`      | *(none)*                             | *(none)*  |
| `pal_category()`   | *(none)*                             | `nominal` |
| `pal_region()`     | *(none)*                             | *(none)*  |
| `pal_sequential()` | `brand`, `complementary`, `colorful` | *(none)*  |
| `pal_diverging()`  | *(none)*                             | *(none)*  |
| `pal_functional()` | *(none)*                             | *(none)*  |
| `pal_gender()`     | *(none)*                             | *(none)*  |
| `pal_trend()`      | *(none)*                             | *(none)*  |

The plots below use **default** arguments only,
e.g. `whopals::pal_gender()` matches
`whopals::pal_gender(theme = "light")`.

## `whopals::pal_theme()`

![](man/figures/README-pal-theme-1.png)<!-- -->

## `whopals::pal_category()`

![](man/figures/README-pal-category-1.png)<!-- -->

## `whopals::pal_region()`

![](man/figures/README-pal-region-1.png)<!-- -->

## `whopals::pal_sequential()`

![](man/figures/README-pal-sequential-1.png)<!-- -->

## `whopals::pal_diverging()`

![](man/figures/README-pal-diverging-1.png)<!-- -->

## `whopals::pal_functional()`

![](man/figures/README-pal-functional-1.png)<!-- -->

## `whopals::pal_gender()`

![](man/figures/README-pal-gender-1.png)<!-- -->

## `whopals::pal_trend()`

![](man/figures/README-pal-trend-1.png)<!-- -->
