library(shiny)
library(ggplot2)

myData <- mpg
names(myData) <- c("Manufacturer","Model","Displacement","Year","Number of Cylinders","Transmission","Drive (Front, Rear, or 4 wheel)","City MPG","Highway MPG","Fuel Type","Class")

numVar <- names(which(lapply(myData,class)=="numeric" | lapply(myData,class)=="integer"))
