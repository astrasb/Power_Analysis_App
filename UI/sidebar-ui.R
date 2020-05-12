column(4,
wellPanel(
    # Input: Select a file
    div(h4("Data Input"),
        class = "text-primary"),
    fileInput("loadfile",
              "Load a .csv file",
              multiple = FALSE),
    p("For .csv file formatting tips
                                 and examples, see Application Instructions
                                 section, below.",
      class = "text-muted"),
    style = "padding-top: 0px;
                               padding-bottom: 0px;"
    
),

wellPanel(
    ## Input: Select a statisical test
    div(h4("Analysis Options"),
        class = "text-primary"
    ),
    selectInput("test_type", 
                "Type of Statistical Test:", 
                choices = c("Unpaired T-test", 
                            "Paired T-test", 
                            "Chi-squared",
                            "One-way ANOVA", 
                            "Two-way ANOVA"),
                selected = "Unpaired T-test"),
    
    ## Input: Select an alpha level
    radioButtons("alpha",
                 "Alpha Level",
                 choices = c(0.05, 0.01),
                 selected = 0.01),
    
    ## Input: Select a power level
    radioButtons("power",
                 "Power Level",
                 choices = c(0.80, 0.90, 0.95),
                 selected = 0.90),
    style = "padding-top: 0px;
                               padding-bottom: 0px;"
))