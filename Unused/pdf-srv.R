output$generate_pdf_report <- downloadHandler(
        filename = function(){
            paste(vals$inputs,"_PowerAnalysis_",Sys.Date(),".pdf",sep = "")
        },
        
        content = function(file){
                removeModal()
            result<-dataOutput()
            if (!is.null(result)){
                
                # Set up parameters to pass to Rmd document
                params <- list(o = vals$o,
                               n = vals$n,
                               v = vals$v,
                               t = vals$t,
                               dat = vals$dat,
                               name = vals$inputs)
                
                # Knit the document, passing in the 'params' list,
                # and eval it in a child of the global environment
                # (this isolates the code in the document
                # from the code in this app)
                withProgress(
                    rmarkdown::render("Server/report.Rmd", 
                                      output_file = file,
                                      output_format = pdf_document(),
                                      params = params,
                                      envir = new.env(parent = globalenv())),
                    message = "Generating PDF Report..."
                )
            }}
    )