# Generate example .csv files for download
exampleOutput <- reactive({
    req(input$example_type) ## Don't run the code unless an output type
    if (grepl('T-test',input$example_type)){
        example_data <- cbind(Control = c(0.3, 0.2, 0.5), 
                              Experimental = c(0.8, 0.7, 1.1))
    } else if (grepl('Chi',input$example_type)){
        example_data <- cbind(Control = 0.5, Experimental = 0.8)
    }else if (grepl('One-way',input$example_type)){
        example_data <- cbind(Control = c(0.3, 0.2, 0.5), 
                              ExperimentalA = c(0.8, 0.7, 1.1), 
                              ExperimentalB = c(0.5, 0.9, 1.3))
    }else if (grepl('Two-way',input$example_type)){
        example_data <- cbind(Control_ConditionA = c(0.3, 0.2, 0.5), 
                              Control_ConditionB = c(0.8, 0.7, 1.1), 
                              Experimental_ConditionA = c(0.1, 0.2, 1.1),
                              Experimental_ConditionB = c(0.5, 0.9, 1.3))
    }
})

output$downloadData<- downloadHandler(
    filename = function(){
        paste('example_',input$example_type, '.csv', sep='')
    },
    content = function(con) {
        example_data <- exampleOutput()
        write.csv(example_data,con)
    }
)