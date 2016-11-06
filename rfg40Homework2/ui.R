library(shiny)

shinyUI(fluidPage(
  
  titlePanel("Homework 2"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("var","Select a Variable for Plotting",numVar), 

      
      selectInput("plotType","Select a Type of Plot",c("Scatterplot", "Tile Plot", "Count Plot", "Regression Line")),
      uiOutput("plotOptionsOne"),
      uiOutput("plotOptionsTwo"),
      uiOutput("plotOptionsThree")
      
    ),
    
    mainPanel(
      plotOutput("myPlot")
    )
  )
))

