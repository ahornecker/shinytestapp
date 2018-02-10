
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(shinydashboard)
library(rhandsontable)

dashboardPage(
    dashboardHeader(title = "Feinstaub Analyzer"),
    dashboardSidebar(
        sidebarMenu(
            menuItem("Upload", tabName = "upload", icon = icon("th")),
            menuItem("Evaluation", tabName = "evaluation", icon = icon("th"))
        )
    ),
    dashboardBody(
        tabItems(
            tabItem(tabName = "upload",
                    h2("Daten hochladen"),
                    fileInput("rawFile", "Upload CSV",
                              accept = c(
                                  "text/csv",
                                  "text/comma-separated-values,text/plain",
                                  ".csv")
                    ),
                    rHandsontableOutput("rawdata")
            ),
            
            tabItem(tabName = "evaluation",
                uiOutput("calculation"),
                downloadButton('downloadData', 'Download')
            )
        )
    )
)