library(ggplot2)

shinyServer(function(input, output) {
  output$myPlot <- renderPlot({
    userData <- data.frame(x = myData[[input$var]])
    if(input$plotType == "Scatterplot") {
      plot(mpg$disp, mpg$cty, col=input$boxColor, pch=input$shape, cex=input$size)
   
    }
    else if(input$plotType == "Tile Plot") {
      #d <- ggplot(mpg, aes(x=mpg$displ, y=mpg$cty)) + geom_tile(aes(fill=mpg$cty)) + scale_fill_gradient(name = 'City Speed Limits', low = 'white', high = 'red') + theme(axis.title.y = element_blank())
      d <- ggplot(mpg, aes(x=mpg$displ, y=mpg$cty)) + geom_bin2d(bins=c(input$xcount,input$ycount))
      
      if(is.null(input$overlay)){
        d
      } else if(input$overlay) {
        d + geom_count()
      } else {
        d
      }
    }
    else if(input$plotType == "Count Plot") {
     ggplot(mpg, aes(x=mpg$displ, y=mpg$cty)) + geom_count()
      
    } 
    else if(input$plotType == "Regression Line") {
      fit <- lm(mpg$cty ~ poly(mpg$displ, input$num))
      if(is.null(input$confidence)){
        predicted.intervals <- 
          predict(fit, data.frame(x=mpg$displ))
      } else if(input$confidence) {
        predicted.intervals <- 
          predict(fit, data.frame(x=mpg$displ), interval='confidence', level=input$cl)
      } else {
        predicted.intervals <- 
          predict(fit, data.frame(x=mpg$displ))
      }
      

      plot(mpg$disp, mpg$cty)
      
      if(is.null(input$confidence)){
        lines(mpg$displ,predicted.intervals)
        
      } else if(input$confidence) {
        lines(mpg$displ,predicted.intervals[,1],col='green',lwd=1)
        
      } else {
        lines(mpg$displ,predicted.intervals)
        
      }
      
    }
  })
  
  output$plotOptionsOne <- renderUI({
    if(input$plotType == "Scatterplot") {
      
      sliderInput("shape","Symbol of Points",min=0,max=23,value=1)
      
    }
    else if(input$plotType == "Tile Plot"){
      sliderInput("xcount", "Number of Bins in X", min=0, max=10, 10 )
    }
    else if (input$plotType == "Count Plot"){
      textInput("title", "Title", "Title")
      
    }else if (input$plotType == "Regression Line"){
      sliderInput("num", "n in Poly", min=1, max=5, value=3)
      
    }
  })
  
  output$plotOptionsTwo <- renderUI({
    if(input$plotType == "Scatterplot") {
      sliderInput("size","Size of Points",min=0,max=2,value=1, step=0.1)
    }
    else if(input$plotType == "Tile Plot"){
      sliderInput("ycount", "Number of Bins in Y", min=0, max=10, 10 )
    }
    else if (input$plotType == "Count Plot"){
      textInput("xaxis", "X-Axis Label", "X")
      
    }
    else if(input$plotType == "Regression Line") {
      
      checkboxInput("confidence","Display confidence band?")
      
      
    }
    
    
  })
  
  output$plotOptionsThree <- renderUI({
    if(input$plotType == "Scatterplot") {
      radioButtons("boxColor","Select a color for boxplot",c("Black","Red","Green","Blue","Yellow"))
    }
    else if (input$plotType == "Count Plot"){
      textInput("yaxis", "Y-Axis Label", "Y")
      
    }
    else if(input$plotType == "Tile Plot") {
      
      checkboxInput("overlay","Overlay points on top?")
      
      
    }
    else if(input$plotType == "Regression Line") {
      
      sliderInput("cl","Confidence Level",min=0,max=1,value=.95, step=0.05)
      
      
    }
  })
  observe({
    print(input$jitter)
  })
  
})
