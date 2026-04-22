
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

Swatches use `theme = "dark"`. Figure titles repeat the R call including
`theme = "dark"`. PNGs are saved with a transparent page background
where supported; the plot area uses a dark face so labels stay readable
on the light github.com page.

**`pal_theme()`**

- **theme**: light, dark

![](man/figures/README-pal-theme-1.png)<!-- -->

**`pal_category()`**

- **component**: base, stronger, text
- **theme**: light, dark

![](man/figures/README-pal-category-1.png)<!-- -->

**`pal_region()`**

- **component**: base, text
- **theme**: light, dark

![](man/figures/README-pal-region-1.png)<!-- -->

**`pal_sequential()`**

- **variant**: brand, complementary, colorful
- **component**: base, secondary, alt
- **theme**: light, dark

![](man/figures/README-pal-sequential-brand-1.png)<!-- -->

![](man/figures/README-pal-sequential-complementary-1.png)<!-- -->

![](man/figures/README-pal-sequential-colorful-1.png)<!-- -->

**`pal_diverging()`**

- **component**: base, alt
- **theme**: light, dark

![](man/figures/README-pal-diverging-1.png)<!-- -->

**`pal_functional()`**

- **theme**: light, dark

![](man/figures/README-pal-functional-1.png)<!-- -->

**`pal_gender()`**

- **theme**: light, dark

![](man/figures/README-pal-gender-1.png)<!-- -->

**`pal_trend()`**

- **component**: base, text, both
- **theme**: light, dark

![](man/figures/README-pal-trend-1.png)<!-- -->
