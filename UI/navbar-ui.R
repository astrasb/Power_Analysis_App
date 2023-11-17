column(4,
       panel(
               heading = tagList(h4(shiny::icon("fas fa-user-edit"), "Data Input & Analysis Options")),
               
               status = "primary",
               h4(shiny::icon("fas fa-file-import"), "Step 1: Input Data", class = "text-danger"),
               p(tags$em("Users may input data as line-separated numbers (i.e. paste data from Excel), 
                 separating columns with semi-colons. Alternatively, users may upload a .csv/.xslx file. For file formatting tips and examples, see Application Instructions section, below.")),
               p(tags$em(tags$b('Note: Please hit the Clear button if switching between typing and uploading inputs.',
                                style = "color: #F39C12"))),
               # Input: Text Box
               textAreaInput('textdat',
                             h5('Type Numerical Data'),
                             rows = 7,
                             resize = "vertical"),
               
               # Input: Select a file
               uiOutput("file_upload"),
       
               tags$hr(style= "border-color: #2C3E50;"),
               
               h4(shiny::icon("fas fa-sliders-h"), "Step 2: Select Analysis Options", class = "text-danger"),
               ## Input: Select a statistical test
               selectInput("test_type", 
                           h5("Type of Statistical Test:"), 
                           choices = c("Unpaired T-test", 
                                       "Paired T-test", 
                                       "Chi-squared",
                                       "One-way ANOVA", 
                                       "Two-way ANOVA"),
                           selected = "Unpaired T-test"),
               
               ## Input: Select an alpha level
               radioButtons("alpha",
                            h5("Alpha Level"),
                            choices = c(0.05, 0.01, 'Custom'),
                            selected = 0.01),
              
               ## Input: Provide a custom alpha level
               textInput("customAlpha",
                         h6("Input a custom alpha value"),
                         "0.001"),
               
               ## Input: Select a power level
               radioButtons("power",
                            h5("Power Level"),
                            choices = c(0.80, 0.90, 0.95, 'Custom'),
                            selected = 0.90),
               
               ## Input: Provide a custom power level
               textInput("customPower",
                         h6("Input a custom power value"),
                         "0.99"),
               
               actionButton("goButton",
                            "Submit",
                            icon = shiny::icon("fas fa-share"),
                            class = "btn-primary"),
               actionButton("reset",
                            "Clear",
                            icon = shiny::icon("far fa-trash-alt"))
       
       
       )
)