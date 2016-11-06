library(shiny)

shinyUI(pageWithSidebar(
  
  headerPanel("Rainier GO?"),
  
  sidebarPanel(
      textInput("caption", "Caption:", "Data Summary"), 
      
      selectInput("dataset", "Choose a dataset:", 
                  choices = c("rock", "pressure", "cars")), 
      
      numericInput("obs", "Number of observations so view:", 10)  
  ), 
  
  mainPanel(
    h3(textOutput("caption")),
    
    verbatimTextOutput("summary"), 
    
    tableOutput("view")
  )  
))