#' WHO data design language embedded colour list (internal).
#'
#' Source of truth for regeneration: inst/colors.json
#' Spec: https://srhdteuwpubsa.z6.web.core.windows.net/gho/data/design-language/design-system/colors/
#'
#' Do not edit by hand unless syncing with the JSON; otherwise run:
#' `Rscript data-raw/build_whopals_colors.R`
#'
#' @keywords internal
#' @noRd
.whopals_colors <-
list(light = list(background = list(selection = "#f0f1f3", base = "#ffffff", 
    weaker = "#f6f7f9"), foreground = list(base = "#222222", 
    weaker = "#71757d", weakest = "#c2c6ce"), text = list(base = "#222222", 
    weaker = "#71757d"), functional = list(accent = "#ffcb01", 
    focus = "#fff400", `not-available` = "#b2b2b2", `not-applicable` = "#f2f2f2", 
    `projected-hatch` = "#ffffff", `filtered-out` = list(base = "#d9dae2", 
        stronger = "#9193ab"), selection = list(`0` = list(base = "#f4a81d", 
        stronger = "#cc850a"), `1` = list(base = "#f26829", stronger = "#e85130"), 
        `2` = list(base = "#bd53bd", stronger = "#bd53bd"), stroke = "#1a1a1a", 
        default = list(base = "#008dc9", stronger = "#008dc9"))), 
    brand = list(base = "#008dc9", stronger = "#0f2d5b", weaker = "#90d3fb"), 
    category = list(base = list(`0` = "#f4a81d", `1` = "#f26829", 
        `2` = "#bd53bd", `3` = "#6363c0", `4` = "#008dc9", `5` = "#40bf73", 
        `99` = "#cccccc"), stronger = list(`0` = "#cc850a", `1` = "#e85130", 
        `2` = "#bd53bd", `3` = "#6363c0", `4` = "#008dc9", `5` = "#37a463", 
        `99` = "#cccccc"), text = list(`0` = "#754d06", `1` = "#9a3709", 
        `2` = "#8e2f8e", `3` = "#4b4baf", `4` = "#245993", `5` = "#1d6339", 
        `99` = "#cccccc"), gender = list(male = "#f4a81d", female = "#6363c0", 
        misc = "#40bf73"), region = list(afro = "#6363c0", amro = "#f26829", 
        emro = "#bd53bd", euro = "#008dc9", searo = "#40bf73", 
        wpro = "#f4a81d"), trend = list(worsening = list(base = "#cf7e50", 
        text = "#b15e2f"), stagnating = list(base = "#746985", 
        text = "#746985"), improving = list(base = "#27a3b4", 
        text = "#19818f"), unspecified = list(base = "#4a4e58", 
        text = "#4a4e58"))), diverging = list(alt = list(`negative-2` = "#a00016", 
        `negative-1` = "#d9777d", neutral = "#d6dae5", `positive-1` = "#53abd0", 
        `positive-2` = "#0f2d5b"), base = list(`negative-2` = "#ee8f00", 
        `negative-1` = "#ebc26f", neutral = "#d6dae5", `positive-1` = "#6fbedf", 
        `positive-2` = "#1c4e94")), sequential = list(brand = list(
        `0` = "#d7e6f3", `1` = "#75b6d6", `2` = "#0582bb", `3` = "#0f2d5b"), 
        complementary = list(`0` = "#f5dbd9", `1` = "#f8908b", 
            `2` = "#da484a", `3` = "#a00016"), colorful = list(
            base = list(`0` = "#fbf6ca", `1` = "#bacf99", `2` = "#8297ec", 
                `3` = "#865fbb", `4` = "#960055"), alt = list(
                `0` = "#fbf6ca", `1` = "#eabd89", `2` = "#c88684", 
                `3` = "#875b9e", `4` = "#1c3e94")))), dark = list(
    background = list(selection = "#282b43", base = "#171a33", 
        weaker = "#24273d"), functional = list(accent = "#ffcb01", 
        focus = "#fff400", `not-available` = "#24273d", `not-applicable` = "#282b40", 
        `projected-hatch` = "#171a33", `filtered-out` = list(
            base = "#343856", stronger = "#5d6284"), selection = list(
            `0` = list(base = "#f4a81d", stronger = "#f4a81d"), 
            `1` = list(stronger = "#fd8750", base = "#f26829"), 
            `2` = list(base = "#bd53bd", stronger = "#ee7cee"), 
            stroke = "#ffffff", default = list(base = "#008dc9", 
                stronger = "#25b3ef"))), brand = list(base = "#008dc9", 
        weaker = "#1f4c7e", stronger = "#90d3fb"), foreground = list(
        base = "#eaeaea", weaker = "#9597ae", weakest = "#696c85"), 
    text = list(base = "#eaeaea", weaker = "#a9abbd"), category = list(
        text = list(`0` = "#f4a81d", `1` = "#fd8750", `2` = "#ee7cee", 
            `3` = "#999ff5", `4` = "#25b3ef", `5` = "#39c671", 
            `99` = "#696c85"), gender = list(male = "#f4a81d", 
            female = "#8a91f3", misc = "#39c671"), region = list(
            afro = "#8a91f3", amro = "#f26829", emro = "#bd53bd", 
            euro = "#008dc9", wpro = "#f4a81d", searo = "#39c671"), 
        base = list(`0` = "#f4a81d", `1` = "#f26829", `2` = "#bd53bd", 
            `3` = "#8a91f3", `4` = "#008dc9", `5` = "#39c671", 
            `99` = "#696c85"), stronger = list(`0` = "#f4a81d", 
            `1` = "#f26829", `2` = "#bd53bd", `3` = "#8a91f3", 
            `4` = "#008dc9", `5` = "#39c671", `99` = "#696c85"), 
        trend = list(worsening = list(base = "#cf7e50", text = "#cf7e50"), 
            stagnating = list(base = "#b2a6cf", text = "#b2a6cf"), 
            improving = list(base = "#27a3b4", text = "#27a3b4"), 
            unspecified = list(base = "#97949a", text = "#97949a"))), 
    diverging = list(alt = list(`negative-2` = "#ff857b", `negative-1` = "#9a5a64", 
        neutral = "#38314d", `positive-1` = "#517699", `positive-2` = "#5ab1ea"), 
        base = list(`negative-2` = "#ffbf42", `negative-1` = "#9e7c4f", 
            neutral = "#3e404f", `positive-1` = "#6286a2", `positive-2` = "#83d2ff")), 
    sequential = list(brand = list(`0` = "#2c3c54", `1` = "#3f5f85", 
        `2` = "#6596bc", `3` = "#83d2ff"), colorful = list(base = list(
        `0` = "#454157", `1` = "#63679b", `2` = "#8592d2", `3` = "#b4ca90", 
        `4` = "#fff48c"), alt = list(`0` = "#2c3a5c", `1` = "#7d448b", 
        `2` = "#c05b8b", `3` = "#de8d65", `4` = "#febb3b")), 
        complementary = list(`0` = "#513545", `1` = "#884e57", 
            `2` = "#c26969", `3` = "#ff857b"))))
