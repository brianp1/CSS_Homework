Tidying `dadmom`
================
Benjamin Soltoff
October 10, 2016

Get the data
============

``` r
library(tidyverse)
library(rcfss)

data("dadmom")
dadmom
```

    ## # A tibble: 3 × 5
    ##   famid named  incd namem  incm
    ##   <dbl> <chr> <dbl> <chr> <dbl>
    ## 1     1  Bill 30000  Bess 15000
    ## 2     2   Art 22000   Amy 18000
    ## 3     3  Paul 25000   Pat 50000

Tidied data
===========

    ## # A tibble: 6 × 4
    ##   famid  type   inc  name
    ## * <dbl> <chr> <int> <chr>
    ## 1     1     d 30000  Bill
    ## 2     1     m 15000  Bess
    ## 3     2     d 22000   Art
    ## 4     2     m 18000   Amy
    ## 5     3     d 25000  Paul
    ## 6     3     m 50000   Pat

Session info
------------

``` r
devtools::session_info()
```

    ##  setting  value                       
    ##  version  R version 3.3.1 (2016-06-21)
    ##  system   x86_64, darwin13.4.0        
    ##  ui       X11                         
    ##  language (EN)                        
    ##  collate  en_US.UTF-8                 
    ##  tz       America/Chicago             
    ##  date     2016-09-29                  
    ## 
    ##  package    * version    date       source                            
    ##  assertthat   0.1        2013-12-06 CRAN (R 3.3.0)                    
    ##  colorspace   1.2-6      2015-03-11 CRAN (R 3.3.0)                    
    ##  DBI          0.5-1      2016-09-10 CRAN (R 3.3.0)                    
    ##  devtools     1.12.0     2016-06-24 CRAN (R 3.3.0)                    
    ##  digest       0.6.10     2016-08-02 CRAN (R 3.3.0)                    
    ##  dplyr      * 0.5.0      2016-06-24 CRAN (R 3.3.0)                    
    ##  evaluate     0.9        2016-04-29 CRAN (R 3.3.0)                    
    ##  formatR      1.4        2016-05-09 CRAN (R 3.3.0)                    
    ##  ggplot2    * 2.1.0.9000 2016-09-29 Github (hadley/ggplot2@03a50ac)   
    ##  gtable       0.2.0      2016-02-26 CRAN (R 3.3.0)                    
    ##  htmltools    0.3.5      2016-03-21 CRAN (R 3.3.0)                    
    ##  knitr        1.14       2016-08-13 CRAN (R 3.3.0)                    
    ##  lazyeval     0.2.0      2016-06-12 CRAN (R 3.3.0)                    
    ##  magrittr     1.5        2014-11-22 CRAN (R 3.3.0)                    
    ##  memoise      1.0.0      2016-01-29 CRAN (R 3.3.0)                    
    ##  munsell      0.4.3      2016-02-13 CRAN (R 3.3.0)                    
    ##  plyr         1.8.4      2016-06-08 CRAN (R 3.3.0)                    
    ##  purrr      * 0.2.2      2016-06-18 CRAN (R 3.3.0)                    
    ##  R6           2.1.3      2016-08-19 CRAN (R 3.3.0)                    
    ##  rcfss      * 0.1.0      2016-09-29 Github (uc-cfss/rcfss@f767843)    
    ##  Rcpp         0.12.7     2016-09-05 cran (@0.12.7)                    
    ##  readr      * 1.0.0      2016-08-03 CRAN (R 3.3.0)                    
    ##  rmarkdown    1.0.9001   2016-07-27 Github (rstudio/rmarkdown@7769342)
    ##  scales       0.4.0      2016-02-26 CRAN (R 3.3.0)                    
    ##  stringi      1.1.1      2016-05-27 CRAN (R 3.3.0)                    
    ##  stringr      1.1.0      2016-08-19 cran (@1.1.0)                     
    ##  tibble     * 1.2        2016-08-26 cran (@1.2)                       
    ##  tidyr      * 0.6.0      2016-08-12 CRAN (R 3.3.0)                    
    ##  tidyverse  * 1.0.0      2016-09-09 CRAN (R 3.3.0)                    
    ##  withr        1.0.2      2016-06-20 CRAN (R 3.3.0)                    
    ##  yaml         2.1.13     2014-06-12 CRAN (R 3.3.0)
