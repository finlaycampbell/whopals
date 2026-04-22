
<!-- README.md is generated from README.Rmd. Please edit README.Rmd and run `rmarkdown::render("README.Rmd")`. -->

# whopals

This package brings the official WHO Data Design Language colour system
into R as named hex values and small functions that return those
palettes, so you can rely on the same published colours as on the WHO
site without typing hex codes by hand. The specification is published by
WHO at [WHO Data Design
Language](https://srhdteuwpubsa.z6.web.core.windows.net/gho/data/design-language/design-system/colors/).

## Installation

``` r
pak::pak("finlaycampbell/whopals")
```

After `library(whopals)`, use `whopals::pal_theme()`,
`whopals::pal_category()`, `whopals::pal_region()`,
`whopals::pal_sequential()`, `whopals::pal_diverging()`,
`whopals::pal_functional()`, `whopals::pal_gender()`, and
`whopals::pal_trend()` (the `whopals::` prefix is optional once the
package is attached). Defaults for each function match the plots below.

### Arguments by palette

**`pal_theme()`**

- **theme**: light, dark

**`pal_category()`**

- **component**: base, stronger, text
- **theme**: light, dark

**`pal_region()`**

- **component**: base, text
- **theme**: light, dark

**`pal_sequential()`**

- **variant**: brand, complementary, colorful
- **component**: base, secondary, alt
- **theme**: light, dark

**`pal_diverging()`**

- **component**: base, alt
- **theme**: light, dark

**`pal_functional()`**

- **theme**: light, dark

**`pal_gender()`**

- **theme**: light, dark

**`pal_trend()`**

- **component**: base, text, both
- **theme**: light, dark

The plots below use default arguments only, for example
`whopals::pal_gender()` matches `whopals::pal_gender(theme = "light")`.

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
