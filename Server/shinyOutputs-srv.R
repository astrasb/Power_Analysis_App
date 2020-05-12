# Parsing results of sample size 
# calculation for Shiny display
output$sample_size<- renderTable({
    result<-dataOutput() 
    if (!is.null(result)){
        vals$o <- dplyr::select(result,
                                -c(note,method,url))
        vals$o}
})

outputOptions(output, 'sample_size', suspendWhenHidden = FALSE)

# Parsing statistical test type for Shiny display
output$test_type <- renderText({
    result<-dataOutput() 
    if (!is.null(result)){
        vals$t <- dplyr::pull(result,method)%>%
            dplyr::first()
        vals$t
    } 
})

# Parsing notes relevent to statistical test type
# for Shiny display
output$test_notes <- renderUI({
    result<-dataOutput() 
    if (!is.null(result)){
        #str0 <- c('<h4 class = "text-primary">Notes</h4>')
        str0 <- dplyr::pull(result,note) %>%
            dplyr::first() %>%
            paste(". ", sep = "")

        str1 <- paste('This calculation assumes that data are ',
                        'pulled from a normal distribution.',
                         sep = "")
        str2 <- paste('If you plan to use a non-parametric test, ',
                    'add 15% to the calculated n.', sep = "")
        vals$n <-data.frame(notes = c(str0,str1,str2))
        apply(vals$n, 1, function(x) tags$p(x['notes']))        
        

    }
})