library(shiny)
library(rhandsontable)

options(shiny.maxRequestSize=30*1024^2)

shinyServer(function(input, output) {
    
    dta <- reactiveValues()
    
    htmlOut <- reactive({
        html <- ""
        html <- paste(html, "<h1>Analyse</h1>")
        if (length(dta$DF) > 0){
            P1 <- as.numeric(dta$DF$P1)
            P2 <- as.numeric(dta$DF$P2)
            
            html <- paste(html, "Mittelwert P1: ", mean(P1), "<br/>")
            html <- paste(html, "Mittelwert P2: ", mean(P2), "<br/>")
            html <- paste(html, "Korrelation: ", cor(P1, P2), "<br/>")
        }
        html
    })
    
    output$rawdata = renderRHandsontable({
        inFile <- input$rawFile
        
        if (is.null(inFile))
            return(NULL)
        
        dta$DF <- read.csv2(inFile$datapath)

        rhandsontable(dta$DF) %>%
            hot_table(highlightCol = TRUE, highlightRow = TRUE)
    })
    
    output$calculation = renderUI({
        HTML(htmlOut())
    })
    
    output$downloadData <- downloadHandler(
        filename = "data.html",
        content = function(file) {
            # Write to a file specified by the 'file' argument
            writeLines(htmlOut(), file)
        }
    )
})
