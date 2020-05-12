# Main panel for displaying outputs
column(8,
       conditionalPanel(condition = "output.sample_size",
                        wellPanel(
                            ## Output: Test type
                            tags$h3(textOutput("test_type"), 
                                    class = "text-warning"),
                            
                            ## Outout: Results table with 
                            # sample size calculation
                            tableOutput("sample_size"),
                            
                            ## Output: Notes re: power analysis
                            tags$h4("Analysis Notes",
                                    class = "text-primary"),
                            htmlOutput("test_notes"),
                            
                            ## Output: Explaining the variables
                            tags$h4("Reported Variables",
                                    class = "text-primary"),
                            uiOutput("variables"),
                            
                            ## Alternative Download
                            actionButton(
                                "generate_report_modal",
                                "Create Report",
                                class = "btn btn-primary"
                            )
                        )
                        
                        
       ),
       ## Error Display
       conditionalPanel(condition = "output.error",
                        wellPanel(
                            # Output: display error codes
                            htmlOutput("error")))
       
)