
<!-- README.md is generated from README.Rmd. Please edit that file -->
Reproduce Results of Gerard and Hoff (2015)
===========================================

This folder contains the code necessary to reproduce the results of Gerard and Hoff (2015). To reproduce these results you will need to:

1.  Download the appropriate R packages.
2.  Run `make`.
3.  Get some coffee.

Download the appropriate R packages.
====================================

You can obtain all of the needed R packages by running the following code in R:

``` r
install.packages(c("tensr", "dplyr", "ggplot2", "tidyr", "xtable", "devtools", "snow"))
devtools::install_github("dcgerard/hose")
```

Run `make`
==========

To reproduce all of the results of Gerard and Hoff (2015), simply run `make` from the terminal (not in the R session). To reproduce figure from Section 2, run

``` shell
make change_sv
```

Get coffee
==========

Some of the simulations will take awhile to run. You should get some coffee! Here is a list of some of my favorites:

-   Chicago
    -   [Sawada Coffee](https://www.yelp.com/biz/sawada-coffee-chicago)
    -   [Plein Air Cafe](https://www.yelp.com/biz/plein-air-cafe-and-eatery-chicago-2)
-   Seattle
    -   [Bauhaus Ballard](https://www.yelp.com/biz/bauhaus-ballard-seattle)
    -   [Cafe Solstice](https://www.yelp.com/biz/cafe-solstice-seattle)
-   Columbus
    -   [Yeah, Me Too](https://www.yelp.com/biz/yeah-me-too-columbus)
    -   [Stauf's Coffee Roasters](https://www.yelp.com/biz/staufs-coffee-roasters-columbus-2)
    -   [Caffe Apropos](https://www.yelp.com/biz/caff%C3%A9-apropos-columbus-2)

Bugs
====

If you have trouble running this code, then it might be that you need to update your R packages. I ran these simulations under these settings:

``` r
sessionInfo()
#> R version 3.3.2 (2016-10-31)
#> Platform: x86_64-pc-linux-gnu (64-bit)
#> Running under: Ubuntu 16.04.2 LTS
#> 
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C              
#>  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=en_US.UTF-8    
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8   
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C                 
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C            
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C       
#> 
#> attached base packages:
#> [1] stats     graphics  grDevices utils     datasets  methods   base     
#> 
#> other attached packages:
#> [1] snow_0.4-2    xtable_1.8-2  tidyr_0.6.0   ggplot2_2.2.1 tensr_1.0.0  
#> [6] hose_0.1.1    dplyr_0.5.0  
#> 
#> loaded via a namespace (and not attached):
#>  [1] Rcpp_0.12.9      knitr_1.15.1     magrittr_1.5     munsell_0.4.3   
#>  [5] colorspace_1.3-2 R6_2.2.0         stringr_1.1.0    plyr_1.8.4      
#>  [9] tools_3.3.2      grid_3.3.2       gtable_0.2.0     DBI_0.5-1       
#> [13] htmltools_0.3.5  yaml_2.1.14      lazyeval_0.2.0   assertthat_0.1  
#> [17] rprojroot_1.2    digest_0.6.11    tibble_1.2       evaluate_0.10   
#> [21] rmarkdown_1.3    stringi_1.1.2    scales_0.4.1     backports_1.0.5
```

If you still have difficulty, please submit an [issue](https://github.com/dcgerard/hose_paper/issues).

References
==========

Gerard, David, and Peter Hoff. 2015. “Adaptive Higher-Order Spectral Estimators.” *ArXiv Preprint ArXiv:1505.02114*. <http://arxiv.org/abs/1505.02114>.
