# Power_Analysis_App
The goal of this project is to generate a Shiny web app for conducing simple power analyses on user-provided data. Most online resources currently require users to provide pre-processed data in the form of individual and group averages. Excel spreadsheets with embedded lookup tables for calculating power analyses require users to be comfortable with several advanced excel features, and assumes familiarity with lookup tables such as those provided by Bausell and Li (2002).  

These requirements may act as a barrier for some researchers. The overall goal of this project is to encourage researchers to conduct power analyses on pilot data by providing a user-friendly web-based application that takes a csv file with raw data as input, and calculates sample sizes for specified power/alpha levels over a set of statistical tests. As much as possible, the results provided by the script have been cross-validating using G*Power.

## Application
The shiny script is located in the file `Power_Analysis_App.R` (and associated sourced filed). `ComputeSampleSize.R` contains the code for the actual calculations. Taken together, the app uses several libraries to calculate effect sizes and power analyses for the separate statistical tests.  
Key amongst these is the WebPower libary, which handles the power analyses. For background/additional references relating to the WebPower library, [the manual is avaliable here](https://webpower.psychstat.org/wiki/_media/grant/webpower_manual_book.pdf).

## UI
The user interface was designed to take either an excel file or a .cvs file input containing raw data that will act as pilot data for calculating an effect size. The effect size will them be used to calculate the required sample size, given selected alpha and power levels. Users can select the alpha/power levels they desire; defaults are set to an alpha level of 0.01 and a power level of 0.9.

## Types of Power Calculations  
The app will calculate the required sample sizes for 5 different types of statistical tests:  

* Unpaired T-test
* Paired T-test
* Chi-squared Test
* One-way ANOVA
* Two-way ANOA  

## Parametric vs Non-parametric tests
For the tests included in this app, the assumption is made that the data are pulled from a normal distribution, i.e. that the statistical test used will be parametric. User's should keep in mind that sample sizes provided may be an underestimation in the case where the intention is to use non-parametric statistical tests. The Prism User Guide suggests that in the absence of easy-to-apply mathematical tools for conducting power analyses of non-parametric data, [values can be estimated calculating the sample size for a parametric test and adding 15%.](https://www.graphpad.com/guides/prism/7/statistics/stat_sample_size_for_nonparametric_.htm)
