observeEvent(input$generate_report_modal, {
    showModal(
        modalDialog(
                fluidRow(
                        column(
                                width = 12,
                                align = "center",
                                downloadButton(
                                        "generate_excel_report",
                                        "Create Excel Report",
                                        style = "width:100%", 
                                        class = "btn btn-primary"
                                )
                        )
                ),
            br(),
            fluidRow(
                    column(
                            width = 12,
                            align = "center",
                            downloadButton(
                                    "generate_pdf_report",
                                    "Create PDF Report",
                                    style = "width:100%", 
                                    class = "btn btn-primary"
                            )
                    )
            ),
            title = "Download Report",
            size = "s",
            footer = list(
                modalButton("Cancel")
            )
        )
    )
}
)