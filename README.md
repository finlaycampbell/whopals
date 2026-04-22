
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

After installing, every palette is exposed as a `whopals::pal_*`
function. Use `theme` to choose a light or dark theme, `component` to
specify the plot component (e.g. base vs text), and `variant` to select
a palette variant where available.

### Palettes

Sequential figures use default `theme` (`light`). Other swatches use
`theme = "dark"`. PNGs use a transparent page background where
supported; the plot area uses a dark face so axis labels stay readable
on the light github.com page.

**`pal_theme()`**

![](man/figures/README-pal-theme-1.png)<!-- -->

**`pal_category()`**

![](man/figures/README-pal-category-1.png)<!-- -->

**`pal_region()`**

![](man/figures/README-pal-region-1.png)<!-- -->

**`pal_sequential()`**

**`pal_sequential("brand")`**

![](man/figures/README-pal-sequential-brand-1.png)<!-- -->

**`pal_sequential("complementary")`**

![](man/figures/README-pal-sequential-complementary-1.png)<!-- -->

**`pal_sequential("colorful")`**

![](man/figures/README-pal-sequential-colorful-1.png)<!-- -->

**`pal_diverging()`**

![](man/figures/README-pal-diverging-1.png)<!-- -->

**`pal_functional()`**

![](man/figures/README-pal-functional-1.png)<!-- -->

**`pal_gender()`**

![](man/figures/README-pal-gender-1.png)<!-- -->

**`pal_trend()`**

![](man/figures/README-pal-trend-1.png)<!-- -->
