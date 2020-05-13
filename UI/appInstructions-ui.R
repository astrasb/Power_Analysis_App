column(12,
       wellPanel(
               h3("Application Instructions", 
                  class = "text-primary"),
               p("To begin, load an Excel or a .csv file containing pilot data.
                                Then select the desired statistical 
                                test using the pull down menu.
                                You may also select the desired 
                                alpha and power levels.
                                The suggested default is an alpha 
                                of 0.01 and a power of 0.9."),
               h4("Formatting your input files", 
                  class = "text-primary"),
               p("Warning, the .csv format is often finicky. Make sure 
                                that your file does not have extraneous 
                                'empty' data columns."),
               h5("T-tests", 
                  class = "text-warning"),
               p("Data should be separated into two
                 adjacent columns (e.g. control vs experimental)."),
               tags$ul(
                       tags$li("For unpaired tests, 
                                        the n per condition does 
                                        not have to be equal."),
                       tags$li("For paired tests, the number of rows 
                                        must either match; 
                                        uneven rows will be ignored.")
               ),
               h5("Chi-squared tests", 
                  class="text-warning"),
               p("Data (proportions) should be
                               separated into two adjacent columns."),
               h5("One-way ANOVA", 
                  class = "text-warning"),
               p("Data should be separated into at least 3
                                adjacent columns. The number of 
                                rows does not have to be even 
                                across all conditions."),
               h5("Two-way ANOVA", 
                  class = "text-warning"),
               p("The power analysis for both main 
                                effects and the interaction
                                effect will be calculated.
                                Data should be arranged in columns as follows:"), 
               tags$ul(
                       tags$li("Column 1: Factor A Condition 1"),
                       tags$li("Column 2: Factor A Condition 2"),
                       tags$li("Column 3: Factor B Condition 1"),
                       tags$li("Column 4: Factor B Condition 2")
               ),
               fluidRow(
                       column(6,
                              div(selectInput("example_type", 
                                              "Download example .csv file:", 
                                              choices = c("Unpaired T-test", 
                                                          "Paired T-test", 
                                                          "Chi-squared",
                                                          "One-way ANOVA", 
                                                          "Two-way ANOVA"),
                                              selected = "Unpaired T-test"),
                                  class = "text-warning",
                                  style = "padding-bottom: 0px"),
                              div(downloadLink('downloadData',
                                               'Download'),
                                  style = "text-align: right;
                                                  padding-top: 0px"))),
               style = "padding-top: 0px;
                               padding-bottom: 5px;")
)