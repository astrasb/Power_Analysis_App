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
library(rmarkdown)
library(openxlsx)
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
                
                ## Sidebar panel for inputs
                #sidebarPanel(
                source("UI/sidebar-ui.R", local = TRUE)$value,
                
                # Main panel for displaying outputs
                source("UI/mainPanel-ui.R", local = TRUE)$value
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
server <- function (input, output){
        # Vals will contain all output variables
        vals <- reactiveValues(o = NULL, v = NULL, t = NULL, n = NULL, dat = NULL, inputs = NULL)
        
        # Sample Size Calculations
        dataOutput <- reactive({
                req(input$loadfile) ## Don't run the code unless a file has been selected
                filename <-(input$loadfile$datapath)
                dat <- read.csv(filename)
                vals$inputs <- input$loadfile$name %>%
                        str_split(pattern = ".csv",
                                  simplify = T) %>%
                        first()
                vals$dat <- dat
                result<-ComputeSampleSize(dat, input, vals)   
        })
        
        # Parse outputs to Shiny UI
        source("Server/shinyOutputs-srv.R", local = TRUE)
        
        # Explanations of Reported Variables
        source("Server/variableCb-srv.R", local = TRUE)
        
        # Generate and Download report
        source("Server/pdf-srv.R", local = TRUE)
        source("Server/excel-srv.R", local = TRUE)
        source("Server/modal-srv.R", local = TRUE)
        
        # Error Messages
        source("Server/error-srv.R", local = TRUE)
        
        # Generate example .csv files for download
        source("Server/exampleCSV-srv.R", local = TRUE)
}
# ---- end_of_chunk ----
#
# Run the App
## ---- runApp ----
shinyApp(ui = ui, server = server)
## ---- end_of_chunk ----
