# Shiny App
## ---- Dependencies ----
library(shiny)
library(shinyWidgets)
library(htmltools)
library(WebPower)
library(reshape2)
library(effsize)
library(tidyverse)
library(readxl)
library(DescTools)
library(powerAnalysis)
library(shinythemes)
library(rmarkdown)
library(openxlsx)
library(knitr)
library(xtable)
source("Server/ComputeSampleSize.R")
## ---- end_of_chunk ----


## Define UI
## ---- UI ----

ui <- fluidPage(
        theme = shinytheme("flatly"),
        
        # App title
        titlePanel(title = h3(shiny::icon("fas fa-calculator"), "Sample Size Calculator", style = "background-color: #2C3E50; color: white; padding: 20px 15px;"), windowTitle = "Sample Size Calc"),
        
        # Panel layout with input and output definitions
        fluidRow(
                
                ## Sidebar panel for inputs
                
                source("UI/navbar-ui.R", local = TRUE)$value,
                
                # Main panel for displaying outputs
                source("UI/mainPanel-ui.R", local = TRUE)$value,
                
                source("UI/custom_css.R", local = T)$value
        ),
        
        # Application Instructions
        fluidRow(
                source("UI/appInstructions-ui.R", local = TRUE)$value
        ),
        
        # About this App (Static)
        fluidRow(
                source("UI/appNotes-ui.R", local = TRUE)$value
        )
)

## ---- end_of_chunk ----

# Define Server Logic
## ---- ServerLogic ----
server <- function (input, output, session){
        # Vals will contain all output variables
        vals <- reactiveValues(o = NULL, v = NULL, t = NULL, 
                               n = NULL, dat = NULL, inputs = NULL)
        
        # Generate/Refresh File Upload UI
        output$file_upload <- renderUI({
                input$reset
                fileInput("loadfile",
                          h5("Upload an input file (Excel or.csv)"),
                          multiple = FALSE)
        })
        
        # Reset Actions
        observeEvent(input$reset,{
                updateTextAreaInput(session, "textdat", value = "")
                updatePickerInput(session, "test_type", selected = "Unpaired T-test")
                updateRadioButtons(session, "alpha", selected = 0.01)
                updateRadioButtons(session, "power", selected = 0.90)
                vals$dat <- NULL
        })
        
        # Sample Size Calculations
        dataOutput <- eventReactive(input$goButton, {
                if(isTruthy(input$textdat)){
                dat.string <- unlist(str_split(input$textdat,";"))
                dat <-sapply(dat.string, function(x){
                        y <- str_split(x, pattern = "\n")
                        as.numeric(y[[1]]) %>% na.omit()       
                }, USE.NAMES = F) 
                if(class(dat) == "list"){
                dat <- plyr::ldply(dat, rbind) %>% 
                        t()}
                dat <- as.data.frame(dat)
                vals$filename<-'UserData'
                
                } else if(isTruthy(input$loadfile)){

                req(input$loadfile) ## Don't run the code unless a file has been selected
                filename <-(input$loadfile$datapath)
                split_filename<-SplitPath(input$loadfile$name)

                ## Import Data, either an xls/xlsx or a csv file
                validate(need(split_filename$extension == "xls"||
                                      split_filename$extension == "xlsx" ||
                                      split_filename$extension == "csv",
                              message = "Please select an Excel or .csv file"))

                if (split_filename$extension == "xls" ||
                    split_filename$extension == "xlsx"){
                        dat <- read_excel(filename)
                } else if (split_filename$extension == "csv") {
                        dat <- read.csv(filename)}

                vals$fullfilename <- split_filename$fullfilename
                vals$filename <-split_filename$filename
                }
                
                vals$dat <- dat
                result<-suppressMessages(ComputeSampleSize(dat, input, vals))   
        })
        
        # Parse outputs to Shiny UI
        source("Server/shinyOutputs-srv.R", local = TRUE)
        
        # Explanations of Reported Variables
        source("Server/variableCb-srv.R", local = TRUE)
        
        # Generate and Download report
        source("Server/excel-srv.R", local = TRUE)
        
        # Error Messages
        source("Server/error-srv.R", local = TRUE)
        
        # Generate example .csv files for download
        source("Server/exampleCSV-srv.R", local = TRUE)
        
        session$onSessionEnded(stopApp)
}
# ---- end_of_chunk ----
#
# Run the App
## ---- runApp ----
shinyApp(ui = ui, server = server)
## ---- end_of_chunk ----
