# Shiny App
## ---- Dependencies ----
library(shiny)
library(WebPower)
library(reshape2)
library(effsize)
library(tidyverse)
library(DescTools)
library(powerAnalysis)
library(shinythemes)
source("ComputeSampleSize.R")
## ---- end_of_chunk ----


## Define UI
## ---- UI ----

ui <- fluidPage(
        theme = shinytheme("darkly"),
        
        # App title
        titlePanel("Sample Size Calculator"),
        
        # Sidebar layout with input and output definitions
        fluidRow(
                
                # Sidebar panel for inputs
                #sidebarPanel(
                column(4,
                       wellPanel(
                               # Input: Select a file
                               fileInput("loadfile",
                                         "Load a file",
                                         multiple = FALSE)
                       ),
                       
                       wellPanel(
                               # Input: Select a statisical test
                               selectInput("test_type", 
                                           "Type of Statistical Test:", 
                                           choices = c("Unpaired T-test", 
                                                       "Paired T-test", 
                                                       "Chi-squared",
                                                       "One-way ANOVA", 
                                                       "Two-way ANOVA"),
                                           selected = "Unpaired T-test"),
                               
                               # Input: Select an alpha level
                               radioButtons("alpha",
                                            "Alpha Level",
                                            choices = c(0.05, 0.01),
                                            selected = 0.01),
                               
                               # Input: Select a power level
                               radioButtons("power",
                                            "Power Level",
                                            choices = c(0.80, 0.90, 0.95),
                                            selected = 0.90)
                       )),
                
                # Main panel for displaying outputs
                column(8,
                       conditionalPanel(condition = "output.sample_size",
                                        wellPanel(
                                                # Output: Test type
                                                tags$h3(textOutput("test_type"), 
                                                        class = "text-warning"),
                                                
                                                # Outout: Results table with 
                                                # sample size calculation
                                                tableOutput("sample_size"),
                                                
                                                # Output: Notes re: power analysis
                                                h4(textOutput("test_notes"), 
                                                   class = "text-primary"))
                                        
                       ),
                       conditionalPanel(condition = "output.error",
                                        wellPanel(
                                                # Output: display error codes
                                                htmlOutput("error")))
                       
                )),
        
        ## Useful input for the user
        fluidRow(
                column(12,
                       wellPanel(
                               h3("Application Instructions", 
                                  class = "text-primary"),
                               p ("To begin, load a .csv file containing pilot data.
                                Then select the desired statistical 
                                test using the pull down menu.
                                You may also select the desired 
                                alpha and power levels.
                                The suggested default is an alpha 
                                of 0.01 and a power of 0.9."),
                               h4("Formatting your .CSV input files", 
                                  class = "text-primary"),
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
                               ul(
                                       li("Column 1: Factor A Condition 1"),
                                       li("Column 2: Factor A Condition 2"),
                                       li("Column 3: Factor B Condition 1"),
                                       li("Column 4: Factor B Condition 2")
                               )
                               
                       ),
                       wellPanel(
                               h4("About this application", 
                                  class = "text-primary"),
                               p("This Shiny app calculates statistical power analyses 
                                on user-provided data pilot data. The app takes a .csv 
                                file with raw data as input, and calculates sample 
                                sizes for specified power and alpha levels for several 
                                common statistical tests.", class = "text-muted"),
                               p("These calculations are primarily powered by the 
                                WebPower Library. For background and/or additional 
                                references relating to the WebPower library, ", 
                                 a(href = "https://webpower.psychstat.org/wiki/", 
                                   "a manual and a wiki site are avaliable online", 
                                   .noWS = "outside"), '.', 
                                 .noWS = c("after-begin", "before-end"), 
                                 class = "text-muted"
                               )))))

## ---- end_of_chunk ----

# Define Server Logic
## ---- ServerLogic ----
server <- function (input, output){
        
        dataOutput <- reactive({
                req(input$loadfile) ## Don't run the code unless a file has been selected
                filename <-(input$loadfile$datapath)
                dat <- read.csv(filename)
                result<-ComputeSampleSize(dat, input)   
        })
        
        output$sample_size<- renderTable({
                result<-dataOutput() 
                if (!is.null(result)){
                        dplyr::select(result,-c(note,method,url))}
        })
        output$test_type <- renderText({
                result<-dataOutput() 
                if (!is.null(result)){
                        dplyr::pull(result,method)%>%
                                dplyr::first()
                } 
        })
        
        output$test_notes <- renderText({
                result<-dataOutput() 
                if (!is.null(result)){
                        dplyr::pull(result,note) %>%
                                dplyr::first()
                }
        })
        
        output$error <- renderUI({
                result<-dataOutput() 
                if (is.null(result)){
                        str0 <-c('<h3 class = "text-danger">Warning</h3>')
                        str1 <-c('<p>Number of data columns or rows does
                                not match the selected statistical test. </p>
                                <p>Please pick another file.</p>')
                        str2 <-c('<p class = "text-muted">
                                Instructions for correct formating of .csv files 
                                can be found under the Application Instructions 
                                section below. </p>')
                        
                        HTML(paste(str0,str1, str2,sep = '<br/>'))}
        })
        
        outputOptions(output, 'sample_size', suspendWhenHidden = FALSE)
        outputOptions(output, 'error', suspendWhenHidden = FALSE)
        
}
# ---- end_of_chunk ----
#
# Run the App
## ---- runApp ----
shinyApp(ui = ui, server = server)
## ---- end_of_chunk ----
