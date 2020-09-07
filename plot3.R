##  EXPLORATORY DATA ANALYSIS - ASSIGNMENT 1
##     R script for constructing Plot 3

library(chron)

## Read in the data
data <- read.csv("./exdata_data_household_power_consumption/household_power_consumption.txt",
                 sep=";", na.strings="?", colClasses=c("character","character",
                                                       "numeric","numeric","numeric","numeric","numeric","numeric","numeric")) 

## Format the date and time, add an abbreviated weekday name
Date <- as.Date(data$Date,"%d/%m/%Y")
Time <- chron(times=data$Time)
Day <- weekdays(Date)
Day_short <-substr(Day,1,3)

formatted_data <- cbind(Day_short,Date,Time,data[,3:9])

## Extract the data for Feb 1 and Feb 2 2007

plot_data3 <- formatted_data[(formatted_data$Date == "2007-02-01" | 
                                formatted_data$Date == "2007-02-02"), ]

## Extract first data point for Feb 3 (Sat) to have complete 
## set for x axis label
plot_data3 <- rbind(plot_data3, formatted_data[69517,])


## Open PNG device; create "plot3.png" in working directory

png(file = "plot3.png", width = 480, height = 480, bg = "white")

## Plot the data and annotate the plot

plot(plot_data3$Sub_metering_1, ylab= "Energy sub metering",
     xaxt="n", xlab=" ", type="l",lwd=1, col="black")
lines(plot_data3$Sub_metering_2, type="l", lwd=1, col="red")
lines(plot_data3$Sub_metering_3, type="l", lwd=1, col="blue")

axis(1, at=c(1,1440,2881), lwd=2, labels=c("Thu","Fri","Sat"))
axis(2, lwd=2)

## Add a legend 

legend("topright", lty=1, lwd = 2, col=c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

## Close the PNG device
dev.off()