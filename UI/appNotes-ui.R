column(12,
       panel(
               heading = tagList(h4(shiny::icon("fas fa-question-circle"),"About this application")),
               status = "primary",
               p("This Shiny app calculates statistical power analyses 
                                on user-provided data pilot data. The app takes a .csv 
                                file with raw data as input, and calculates sample 
                                sizes for specified power and alpha levels for several 
                                common statistical tests."),
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
                 .noWS = c("after-begin", "before-end")),
               p("These calculations are primarily powered by the 
                                WebPower Library. For background and/or additional 
                                references relating to the WebPower library, ", 
                 a(href = "https://webpower.psychstat.org/wiki/", 
                   "a manual and a wiki site are avaliable online", 
                   .noWS = "outside"), '.', 
                 .noWS = c("after-begin", "before-end")),
               p('This app was created by', 
                 tags$a(
                         href = "https://scholar.google.com/citations?user=uSGqqakAAAAJ&hl=en", 
                         'Astra S. Bryant, PhD'),'for the ',
                 tags$a(href="http://www.hallemlab.com/",'Hallem Lab'), 'at UCLA.', 
                 tags$br(),
                 'The underlying code is available on Github:', 
                 tags$a(
                         href = 'https://github.com/astrasb/Power_Analysis_App', "Power Analysis App Repository")),
               style = "padding-top: 10px;
                               padding-bottom: 0px;")
)