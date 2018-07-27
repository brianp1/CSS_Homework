Exploring World Bank Data
================
Your Name
October 19, 2016

Load necessary libraries
------------------------

``` r
library(tidyverse)
```

    ## Loading tidyverse: ggplot2
    ## Loading tidyverse: tibble
    ## Loading tidyverse: tidyr
    ## Loading tidyverse: readr
    ## Loading tidyverse: purrr
    ## Loading tidyverse: dplyr

    ## Conflicts with tidy packages ----------------------------------------------

    ## filter(): dplyr, stats
    ## lag():    dplyr, stats

Write a function to import the data files
-----------------------------------------

``` r
import <- function(file){
df <- read_csv(file, skip = 4) 
    df$X62 <- NULL
    df$`Indicator Code` <- NULL
    df$`Country Code` <- NULL
    df <- gather(df, year, values, `1960`:`2016`)
    df <- spread(df, `Indicator Name`, values)
}
```

Import the data
---------------

``` r
finaldata <- list.files("data_world_bank", full.names = TRUE) %>%
  map_df(import)
```

    ## Warning: Missing column names filled in: 'X62' [62]

    ## Parsed with column specification:
    ## cols(
    ##   .default = col_double(),
    ##   `Country Name` = col_character(),
    ##   `Country Code` = col_character(),
    ##   `Indicator Name` = col_character(),
    ##   `Indicator Code` = col_character(),
    ##   X62 = col_character()
    ## )

    ## See spec(...) for full column specifications.

    ## Warning: Missing column names filled in: 'X62' [62]

    ## Parsed with column specification:
    ## cols(
    ##   .default = col_double(),
    ##   `Country Name` = col_character(),
    ##   `Country Code` = col_character(),
    ##   `Indicator Name` = col_character(),
    ##   `Indicator Code` = col_character(),
    ##   X62 = col_character()
    ## )
    ## See spec(...) for full column specifications.

    ## Warning: Missing column names filled in: 'X62' [62]

    ## Parsed with column specification:
    ## cols(
    ##   .default = col_double(),
    ##   `Country Name` = col_character(),
    ##   `Country Code` = col_character(),
    ##   `Indicator Name` = col_character(),
    ##   `Indicator Code` = col_character(),
    ##   X62 = col_character()
    ## )
    ## See spec(...) for full column specifications.

    ## Warning: Missing column names filled in: 'X62' [62]

    ## Parsed with column specification:
    ## cols(
    ##   .default = col_double(),
    ##   `Country Name` = col_character(),
    ##   `Country Code` = col_character(),
    ##   `Indicator Name` = col_character(),
    ##   `Indicator Code` = col_character(),
    ##   `2016` = col_integer(),
    ##   X62 = col_character()
    ## )
    ## See spec(...) for full column specifications.

    ## Warning: Missing column names filled in: 'X62' [62]

    ## Parsed with column specification:
    ## cols(
    ##   .default = col_double(),
    ##   `Country Name` = col_character(),
    ##   `Country Code` = col_character(),
    ##   `Indicator Name` = col_character(),
    ##   `Indicator Code` = col_character(),
    ##   `2016` = col_integer(),
    ##   X62 = col_character()
    ## )
    ## See spec(...) for full column specifications.

    ## Warning: Missing column names filled in: 'X62' [62]

    ## Parsed with column specification:
    ## cols(
    ##   .default = col_double(),
    ##   `Country Name` = col_character(),
    ##   `Country Code` = col_character(),
    ##   `Indicator Name` = col_character(),
    ##   `Indicator Code` = col_character(),
    ##   `2016` = col_integer(),
    ##   X62 = col_character()
    ## )
    ## See spec(...) for full column specifications.

    ## Warning: Missing column names filled in: 'X62' [62]

    ## Parsed with column specification:
    ## cols(
    ##   .default = col_double(),
    ##   `Country Name` = col_character(),
    ##   `Country Code` = col_character(),
    ##   `Indicator Name` = col_character(),
    ##   `Indicator Code` = col_character(),
    ##   `2016` = col_integer(),
    ##   X62 = col_character()
    ## )
    ## See spec(...) for full column specifications.

    ## Warning: Missing column names filled in: 'X62' [62]

    ## Parsed with column specification:
    ## cols(
    ##   .default = col_double(),
    ##   `Country Name` = col_character(),
    ##   `Country Code` = col_character(),
    ##   `Indicator Name` = col_character(),
    ##   `Indicator Code` = col_character(),
    ##   X62 = col_character()
    ## )
    ## See spec(...) for full column specifications.

    ## Warning: Missing column names filled in: 'X62' [62]

    ## Parsed with column specification:
    ## cols(
    ##   .default = col_double(),
    ##   `Country Name` = col_character(),
    ##   `Country Code` = col_character(),
    ##   `Indicator Name` = col_character(),
    ##   `Indicator Code` = col_character(),
    ##   `2016` = col_integer(),
    ##   X62 = col_character()
    ## )
    ## See spec(...) for full column specifications.

    ## Warning: Missing column names filled in: 'X62' [62]

    ## Parsed with column specification:
    ## cols(
    ##   .default = col_double(),
    ##   `Country Name` = col_character(),
    ##   `Country Code` = col_character(),
    ##   `Indicator Name` = col_character(),
    ##   `Indicator Code` = col_character(),
    ##   X62 = col_character()
    ## )
    ## See spec(...) for full column specifications.

    ## Warning: Missing column names filled in: 'X62' [62]

    ## Parsed with column specification:
    ## cols(
    ##   .default = col_double(),
    ##   `Country Name` = col_character(),
    ##   `Country Code` = col_character(),
    ##   `Indicator Name` = col_character(),
    ##   `Indicator Code` = col_character(),
    ##   X62 = col_character()
    ## )
    ## See spec(...) for full column specifications.

    ## Warning: Missing column names filled in: 'X62' [62]

    ## Parsed with column specification:
    ## cols(
    ##   .default = col_double(),
    ##   `Country Name` = col_character(),
    ##   `Country Code` = col_character(),
    ##   `Indicator Name` = col_character(),
    ##   `Indicator Code` = col_character(),
    ##   X62 = col_character()
    ## )
    ## See spec(...) for full column specifications.

    ## Warning: Missing column names filled in: 'X62' [62]

    ## Parsed with column specification:
    ## cols(
    ##   .default = col_double(),
    ##   `Country Name` = col_character(),
    ##   `Country Code` = col_character(),
    ##   `Indicator Name` = col_character(),
    ##   `Indicator Code` = col_character(),
    ##   X62 = col_character()
    ## )
    ## See spec(...) for full column specifications.

    ## Warning: Missing column names filled in: 'X62' [62]

    ## Parsed with column specification:
    ## cols(
    ##   .default = col_double(),
    ##   `Country Name` = col_character(),
    ##   `Country Code` = col_character(),
    ##   `Indicator Name` = col_character(),
    ##   `Indicator Code` = col_character(),
    ##   `2016` = col_integer(),
    ##   X62 = col_character()
    ## )
    ## See spec(...) for full column specifications.

    ## Warning: Missing column names filled in: 'X62' [62]

    ## Parsed with column specification:
    ## cols(
    ##   .default = col_double(),
    ##   `Country Name` = col_character(),
    ##   `Country Code` = col_character(),
    ##   `Indicator Name` = col_character(),
    ##   `Indicator Code` = col_character(),
    ##   X62 = col_character()
    ## )
    ## See spec(...) for full column specifications.

Explore the data
----------------

``` r
finaldata %>%
  select(year, `Country Name`, `Adjusted net national income (current US$)`)%>%
  group_by(`Country Name`, na.rm = FALSE) %>%
  ggplot(aes(x= year, y= `Adjusted net national income (current US$)`, color= `Country Name`)) +
    geom_smooth()
```

I was still working on the data analysis, but here is what I have so far for this section too \#\# Session info

``` r
devtools::session_info()
```

    ## Session info --------------------------------------------------------------

    ##  setting  value                       
    ##  version  R version 3.3.1 (2016-06-21)
    ##  system   x86_64, mingw32             
    ##  ui       RTerm                       
    ##  language (EN)                        
    ##  collate  English_United States.1252  
    ##  tz       America/Chicago             
    ##  date     2016-10-24

    ## Packages ------------------------------------------------------------------

    ##  package    * version date       source        
    ##  assertthat   0.1     2013-12-06 CRAN (R 3.3.1)
    ##  colorspace   1.2-6   2015-03-11 CRAN (R 3.3.1)
    ##  DBI          0.5-1   2016-09-10 CRAN (R 3.3.1)
    ##  devtools     1.12.0  2016-06-24 CRAN (R 3.3.1)
    ##  digest       0.6.10  2016-08-02 CRAN (R 3.3.1)
    ##  dplyr      * 0.5.0   2016-06-24 CRAN (R 3.3.1)
    ##  evaluate     0.9     2016-04-29 CRAN (R 3.3.1)
    ##  formatR      1.4     2016-05-09 CRAN (R 3.3.1)
    ##  ggplot2    * 2.1.0   2016-03-01 CRAN (R 3.3.1)
    ##  gtable       0.2.0   2016-02-26 CRAN (R 3.3.1)
    ##  htmltools    0.3.5   2016-03-21 CRAN (R 3.3.1)
    ##  knitr        1.14    2016-08-13 CRAN (R 3.3.1)
    ##  lazyeval     0.2.0   2016-06-12 CRAN (R 3.3.1)
    ##  magrittr     1.5     2014-11-22 CRAN (R 3.3.1)
    ##  memoise      1.0.0   2016-01-29 CRAN (R 3.3.1)
    ##  munsell      0.4.3   2016-02-13 CRAN (R 3.3.1)
    ##  plyr         1.8.4   2016-06-08 CRAN (R 3.3.1)
    ##  purrr      * 0.2.2   2016-06-18 CRAN (R 3.3.1)
    ##  R6           2.1.3   2016-08-19 CRAN (R 3.3.1)
    ##  Rcpp         0.12.7  2016-09-05 CRAN (R 3.3.1)
    ##  readr      * 1.0.0   2016-08-03 CRAN (R 3.3.1)
    ##  rmarkdown    1.0     2016-07-08 CRAN (R 3.3.1)
    ##  scales       0.4.0   2016-02-26 CRAN (R 3.3.1)
    ##  stringi      1.1.1   2016-05-27 CRAN (R 3.3.1)
    ##  stringr      1.1.0   2016-08-19 CRAN (R 3.3.1)
    ##  tibble     * 1.2     2016-08-26 CRAN (R 3.3.1)
    ##  tidyr      * 0.6.0   2016-08-12 CRAN (R 3.3.1)
    ##  tidyverse  * 1.0.0   2016-09-09 CRAN (R 3.3.1)
    ##  withr        1.0.2   2016-06-20 CRAN (R 3.3.1)
    ##  yaml         2.1.13  2014-06-12 CRAN (R 3.3.1)
