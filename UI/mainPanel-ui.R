# Main panel for displaying outputs
column(8,
       conditionalPanel(condition = "output.sample_size",
                        panel(
                                heading = tagList(h4(shiny::icon("fas fa-table"),
                                                     "Analysis Results")),
                                status = "primary",
                            ## Output: Test type
                            tags$h4(textOutput("test_type"), 
                                    class = "text-danger"),
                            
                            ## Output: Results table with 
                            # sample size calculation
                            tableOutput("sample_size"),
                            
                            ## Output: Notes re: power analysis
                            tags$h5("Analysis Notes",
                                    class = "text-primary"),
                            htmlOutput("test_notes"),
                            
                            ## Output: Explaining the variables
                            tags$h5("Reported Variables",
                                    class = "text-primary"),
                            uiOutput("variables"),
                            
                            ## Alternative Download
                            downloadButton(
                                    "generate_excel_report",
                                    "Create Excel Report",
                                    class = "btn btn-primary"
                            )
                        )
                        
                        
       ),
       ## Error Display
       conditionalPanel(condition = "output.error",
                        panel(
                                heading = tagList(h4(shiny::icon("fas fa-exclamation-triangle"),
                                                     "Error")),
                                status = "danger",
                            # Output: display error codes
                            htmlOutput("error")))
       
)