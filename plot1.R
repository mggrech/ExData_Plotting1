##  EXPLORATORY DATA ANALYSIS - ASSIGNMENT 1
##     R script for constructing Plot 1
library(chron)

## Read in the data
data <- read.csv("./exdata_data_household_power_consumption/household_power_consumption.txt",
                 sep=";", na.strings="?", colClasses=c("character","character",
                 "numeric","numeric","numeric","numeric","numeric","numeric","numeric")) 

## Convert the date and time to Date and Time classes

Date <- as.Date(data$Date,"%d/%m/%Y")
Time <- chron(times=data$Time)

formatted_data <- cbind(Date,Time,data[,3:9])

## Extract the data for 2007-02-01 and 2007-02-02 for plotting

select_day1 <- (formatted_data$Date == "2007-02-01")
day1 <- formatted_data[select_day1,]

select_day2 <- (formatted_data$Date == "2007-02-02")
day2 <- formatted_data[select_day2,]

plot_data <- rbind(day1,day2)

## Open PNG device; create "plot1.png" in working directory

png(file = "plot1.png", width = 480, height = 480, bg = "white")

## Create the plot and send it to the file

hist(plot_data$Global_active_power, main = "Global Active Power",
     xlab= "Global Active Power (kilowatts)", col="red")

## Close the PNG device

dev.off()

