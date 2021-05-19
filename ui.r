## loading packages
library(shiny)
library(shinydashboard)
library(htmltools)
library(rvest)
library(XML)
library(measurements)
library(ggplot2)
library(ggrepel)
library(plotly)
library(tableHTML)
library(shinycssloaders)
library(shinyWidgets)

#reading csv
ProjectEvaluations <- read.csv("ProjectEvaluations.csv")


#ui
ui <- dashboardPage(
  dashboardHeader(title = span("", 
                               span("PEST - \nProject Evaluation Study & Test v0.7", 
                                    style = "color: white; font-size: 40px;font-weight: bold")), titleWidth = 1500),
  dashboardSidebar(
    
    collapsed = TRUE
    
  ),
  
  dashboardBody(
    
    fluidPage(
      
      tags$head(
        tags$style(
          HTML('
        body, label, input, button, select { 
          font-family: "Helvetica Neue",Helvetica,Arial,sans-serif;
          font-size: 15px;
          color: black;
        }')
        )),
      
      sidebarLayout(
        
        sidebarPanel(
          
          #ensures input panel updates as the data updates
          lapply(4:ncol(ProjectEvaluations)-3, function(i) {
            
            selectInput(intToUtf8(96+i),colnames(ProjectEvaluations[i]),
                        choices = unique(ProjectEvaluations[[i]]),
                        selected = NULL)
            
          }),
          
          #ensures updated output is shown only when action button is clicked
          # and not when any one input is changed by the user
          actionButton("Button", "Update")
          
        ),
        
        mainPanel(
          
          fluidRow(valueBoxOutput("info_box1", "100%")),
          
          fluidRow(valueBoxOutput("info_box2", width = "100%")),
          
          fluidRow(withSpinner(plotlyOutput("distribution")), width = "100%", height = "100%")
        )
        
      )
      
    )
    
  )
)
