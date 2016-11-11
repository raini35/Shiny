library(shiny)
library(reshape)
shinyServer(function(input, output) {
  output$timePlot <- renderPlot({
    currentData <- subset(mydata,year==input$animation)
    
    mydata$color <- rgb(0,0,0, alpha=0)
    mydata$color[mydata$year < currentData$year] = rgb(0,0,0, alpha=.1)
    mydata$color[mydata$year == currentData$year]= "black"

    ggplot(mydata,aes(month,temp, group=year))+
      geom_line(color=mydata$color)+scale_x_continuous(lim=c(1,12))+
      theme_classic()+coord_cartesian(ylim=c(-6,6)) 
  })
  
})
