shinyUI(fluidPage(
  titlePanel("Animated Time Series"),

    sidebarLayout(
    sidebarPanel(
       sliderInput("animation", "Looping Animation:", 1900, 2016, 1900, step = 1,
                   animate=animationOptions(interval=300, loop=T))
      #sliderInput("animation", "Looping Animation:", 2, 12, 2, step = 1, 
       #           animate=animationOptions(interval=300, loop=T))
      ),

      mainPanel(
       plotOutput("timePlot")
    )
  )
))
