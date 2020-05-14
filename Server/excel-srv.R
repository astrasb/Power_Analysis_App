output$generate_excel_report <- downloadHandler(

    filename = function(){
        paste(vals$filename,"_PowerAnalysis_",Sys.Date(),".xlsx",sep = "")
    },
    
    content = function(file){
       removeModal() 
    
        # Workbook
        to_download <<- createWorkbook()
        addWorksheet(wb = to_download, sheetName = vals$filename)
        
        # Write Data
        ## Sheet header
        writeData(
            to_download,
            sheet = 1,
            x = c(
                paste0("Power analysis report for a ",vals$t),
                paste0("Report generated on ", format(Sys.Date(), "%B %d, %Y"))
            )
        )
        
        ## Results of power analysis
        writeData(
            to_download,
            sheet = 1,
            x = vals$o,
            startRow = 4,
            startCol = 1,
            headerStyle = createStyle(
                textDecoration = "Bold",
                halign = "center",
                border = "bottom"
            )
        )
        
        ## Analysis notes
        writeData(
            to_download,
            sheet = 1,
            x = c('Analysis Notes'),
            startRow = 15,
            startCol = 1
        )
        
        
        writeData(
            to_download,
            sheet = 1,
            x = vals$n,
            startRow = 16,
            startCol = 1,
            colNames = FALSE
        )
        
        ## Reported variables explainer
        writeData(
            to_download,
            sheet = 1,
            x = c('Reported Variables'),
            startRow = 20,
            startCol = 1
        )
        
        writeData(
            to_download,
            sheet = 1,
            x = vals$v,
            startRow = 21,
            startCol = 1,
            colNames = FALSE
        )
        
        ## Header for user-input data
        writeData(
            to_download,
            sheet = 1,
            startRow = 1,
            startCol = 10,
            x = c(
                "User-provided pilot data",
                paste0(
                "Soure file: ",
                vals$fullfilename
                )
            )
        )
        
        ## Copy of uploaded data
        writeData(
            to_download,
            sheet = 1,
            x = vals$dat,
            startRow = 4,
            startCol = 10,
            headerStyle = createStyle(
                textDecoration = "Bold",
                halign = "center",
                border = "bottom"
            )
        )
        
        # Styling
        ## Styling the title row
        addStyle(
            to_download,
            sheet = 1,
            rows = 1,
            cols = 1:10,
            style = createStyle(
                fontSize = "14",
                textDecoration = "bold"
            )
        )
        
        addStyle(
            to_download,
            sheet = 1,
            rows = 15,
            cols = 1,
            style = createStyle(
                fontSize = "14",
                textDecoration = "bold"
            )
        )
        
        addStyle(
            to_download,
            sheet = 1,
            rows = 20,
            cols = 1,
            style = createStyle(
                fontSize = "14",
                textDecoration = "bold"
            )
        )
        withProgress(
        saveWorkbook(to_download, file),
        message = "Generating Excel Report")
    }
)