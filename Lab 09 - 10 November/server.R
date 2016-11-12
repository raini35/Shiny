library(shiny)
library(reshape)
shinyServer(function(input, output) {
  max <- reactiveValues(
    avgTemp = 0
  )
  
  output$timePlot <- renderPlot({
    currentData <- subset(mydata,year==input$animation)
    
    colfunc<-colorRampPalette(c("red","royalblue"))
    
    mydata$color <- 0
    firstLim <- (currentData$year - mydata$year[1])/3
    secondLim <- ((currentData$year - mydata$year[1])*2)/3

    mydata$color[(currentData$year - mydata$year) >= firstLim  ] = .1
    mydata$color[(currentData$year - mydata$year) > firstLim && (currentData$year - mydata$year) <= secondLim  ] = .3
    mydata$color[(currentData$year - mydata$year) > secondLim && (currentData$year - mydata$year) < secondLim ] = .5
    
    mydata$color[mydata$year == currentData$year]= 1
    
    ggplot(mydata,aes(month,temp, group=year,col=avgTemp))+ labs(x="Months", y="Temperature in Degrees") +
      geom_line(alpha=mydata$color)+ scale_x_continuous(lim=c(1,11.5))+
      theme_classic()+coord_cartesian(ylim=c(-6,6)) + geom_hline(yintercept=max$avgTemp,
                                                                 linetype="dashed")+
      scale_colour_gradient(low='blue', high='red')
  })
  
  observeEvent(input$animation, {
    currentData <- subset(mydata,year==input$animation)
    if(max$avgTemp < currentData$avgTemp){
      max$avgTemp <- currentData$avgTemp
    }
  })
  
})
