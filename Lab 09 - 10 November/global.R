library(shiny)
library(ggplot2)

years <- 1900:2016
monthlymeans <- sin((1:12)*2*pi/12)
yearlymeans <- rnorm(length(years))

temps <- rep(NA,12*length(years))
year <- rep(NA,12*length(years))
month <- rep(NA,12*length(years))
monthYearDate <- rep(NA,12*length(years))
averageTemp <- rep(NA, 12*length(years))
for(i in 1:length(years)){
  sum <- 0 
  for(j in 1:12){
    year[(i-1)*12+j] <- years[i]
    month[(i-1)*12+j] <- j
    temps[(i-1)*12+j] <- yearlymeans[i]+monthlymeans[j]+rnorm(1,0,2)
    monthYearDate[(i-1)*12+j] <- paste(years[i],"-",j,"-",1,sep="")
  }

}

for(i in 1:length(years)){
  sum <- 0 
  average <- 0
  for(h in 1:12){
    sum <- temps[(i-1)*12+h]
  }
  average <- sum / 12
  for(j in 1:12){
    averageTemp[(i-1)*12+j] <- average
  }

}
monthYearDate<-as.Date(monthYearDate)

mydata <- data.frame(year=year,month=month,temp=temps,monthyear=monthYearDate, avgTemp = averageTemp)
