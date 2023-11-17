## Install packages required for local instance of Power Analysis App

setRepositories(ind = c(1,2,3,4,5))
if (!requireNamespace("pacman", quietly = TRUE))
        install.packages("pacman")
library(pacman)

pacman::p_load(shiny,shinyWidgets,htmltools,WebPower,reshape2,effsize,tidyverse,readxl,DescTools,shinythemes,rmarkdown,openxlsx,knitr,xtable)

if (!requireNamespace("devtools", quietly = TRUE))
        install.packages("devtools")
devtools::install_github("cran/powerAnalysis")