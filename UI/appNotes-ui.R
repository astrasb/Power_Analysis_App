column(12,
       wellPanel(
               h4("About this application", 
                  class = "text-primary"),
               p("This Shiny app calculates statistical power analyses 
                                on user-provided data pilot data. The app takes a .csv 
                                file with raw data as input, and calculates sample 
                                sizes for specified power and alpha levels for several 
                                common statistical tests.", class = "text-muted"),
               p("For all these tests, the assumption is made that the 
                               data are pulled from a normal distribution, 
                               i.e. that the statistical test used will be parametric. 
                               Keep in mind that sample sizes provided may be an 
                               underestimation in the case where the intention is 
                               to use non-parametric statistical tests. 
                               The Prism User Guide suggests that in the absence of 
                               easy-to-apply mathematical tools for conducting power 
                               analyses of non-parametric data, ", 
                 a(href = "https://www.graphpad.com/guides/prism/7/
                                   statistics/stat_sample_size_for_nonparametric_.htm",
                   "values can be estimated calculating the sample size 
                                   for a parametric test and adding 15%",
                   .noWS = "outside"),".",
                 .noWS = c("after-begin", "before-end"), 
                 class = "text-muted"),
               p("These calculations are primarily powered by the 
                                WebPower Library. For background and/or additional 
                                references relating to the WebPower library, ", 
                 a(href = "https://webpower.psychstat.org/wiki/", 
                   "a manual and a wiki site are avaliable online", 
                   .noWS = "outside"), '.', 
                 .noWS = c("after-begin", "before-end"), 
                 class = "text-muted"
               ),
               p("Created by Astra S, Bryant, PhD",
                 class = "text-muted"),
               style = "padding-top: 0px;
                               padding-bottom: 0px;")
)