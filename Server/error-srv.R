# Error Messages
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
outputOptions(output, 'error', suspendWhenHidden = FALSE)