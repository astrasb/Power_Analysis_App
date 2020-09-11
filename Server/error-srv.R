# Error Messages
output$error <- renderUI({
    result<-dataOutput() 
    if (is.null(result)){
        str1 <-c('<h5>Number of data columns or rows does
                                not match the selected statistical test. </h5>
                                <h5>Please pick another file.</h5>')
        str2 <-c('<p>
                                Instructions for correct formating of data inputs 
                                can be found under the Application Instructions 
                                section below. <p>')
        
        HTML(paste(str1, str2,sep = '<br/>'))}
})
outputOptions(output, 'error', suspendWhenHidden = FALSE)