#Load in necessary libraries
library(dplyr)
library(data.table)

#Reading the data in R , NA strings = ?
elecdata <- fread("courseraproject/Exploratory data analysis/household_power_consumption.txt", na.strings="?",stringsAsFactors = FALSE)
#filtering the data for 2 dates mentioned in the assigment 
powerdata <- filter(elecdata, grep("^[1,2]/2/2007", Date))

#deleting the original data variable which is not required now 
rm(elecdata)

#Convert global active power column, global reactive power colums, Sub_metering columns, and the Voltage column to numeric
powerdata$Global_active_power <- as.numeric(as.character(powerdata$Global_active_power))
powerdata$Global_reactive_power <- as.numeric(as.character(powerdata$Global_reactive_power))
powerdata$Sub_metering_1 <- as.numeric(as.character(powerdata$Sub_metering_1))
powerdata$Sub_metering_2 <- as.numeric(as.character(powerdata$Sub_metering_2))
powerdata$Sub_metering_3 <- as.numeric(as.character(powerdata$Sub_metering_3))
powerdata$Voltage <- as.numeric(as.character(powerdata$Voltage))
#adding a new column for combined date and time stamp
powerdata$Timestamp <-paste(powerdata$Date, powerdata$Time)
#initiating a png file for charting( opening the png device)
png("courseraproject/ExData_Plotting1/plot1.png")
#making the chart for global active power, default size is 480*480 for png
hist(powerdata$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
#closing the device  
dev.off()




