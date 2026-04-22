
<!-- README.md is generated from README.Rmd. Please edit README.Rmd and run `rmarkdown::render("README.Rmd")`. -->

# whopals

This package brings the official [WHO Data Design
Language](https://srhdteuwpubsa.z6.web.core.windows.net/gho/data/design-language/design-system/colors/)
colours into R. Install it using:

``` r
pak::pak("finlaycampbell/whopals")
```

Palettes are exposed as `whopals::pal_*` functions. Use the `theme`
argument to specify a light or dark theme, `component` to specify the
plot component such as text or base, and `variant` to select a palette
variant where available. The available palettes are displayed below.

------------------------------------------------------------------------

**`pal_region()`**

![](man/figures/README-pal-region-1.png)<!-- -->

**`pal_trend()`**

![](man/figures/README-pal-trend-1.png)<!-- -->

**`pal_gender()`**

![](man/figures/README-pal-gender-1.png)<!-- -->

**`pal_category()`**

![](man/figures/README-pal-category-1.png)<!-- -->

**`pal_sequential("brand")`**

![](man/figures/README-pal-sequential-brand-1.png)<!-- -->

**`pal_sequential("complementary")`**

![](man/figures/README-pal-sequential-complementary-1.png)<!-- -->

**`pal_sequential("colorful")`**

![](man/figures/README-pal-sequential-colorful-1.png)<!-- -->

**`pal_diverging("base")`**

![](man/figures/README-pal-diverging-base-1.png)<!-- -->

**`pal_diverging("alt")`**

![](man/figures/README-pal-diverging-alt-1.png)<!-- -->

**`pal_brand()`**

![](man/figures/README-pal-brand-1.png)<!-- -->

**`pal_foreground()`**

![](man/figures/README-pal-foreground-1.png)<!-- -->

**`pal_background()`**

![](man/figures/README-pal-background-1.png)<!-- -->

**`pal_text()`**

![](man/figures/README-pal-text-1.png)<!-- -->

**`pal_functional()`**

![](man/figures/README-pal-functional-1.png)<!-- -->

**`pal_selection()`**

![](man/figures/README-pal-selection-1.png)<!-- -->

## Example column chart

The figures below give an example of the color palettes using the light
and dark themes.

![](man/figures/README-example-column-dark-1.png)<!-- -->

![](man/figures/README-example-column-light-1.png)<!-- -->
