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

#initiating a png file for charting( opening the png device, default size 480*480)
png("courseraproject/ExData_Plotting1/plot4.png")

#Setting graphing parameters (par) so that 4 graphs are drawn by 2*2 column
par(mfcol = c(2,2))

#Chart1
# making graph of date/time vs global active power data, same as plot2
plot(strptime(powerdata$Timestamp, "%d/%m/%Y %H:%M:%S"), powerdata$Global_active_power, type = "l", 
     xlab = "", ylab = "Global Active Power(kilowatts)")

#Chart2
#creating second chart, same as plot3 in which we have to add lines for submetering; this will be below 1st chart in first column 
plot(strptime(powerdata$Timestamp, "%d/%m/%Y %H:%M:%S"), powerdata$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")

#Adds line graph for date/time v Sub metering 2 data in red
lines(strptime(powerdata$Timestamp, "%d/%m/%Y %H:%M:%S"), powerdata$Sub_metering_2, type = "l", col = "red" )

#Adds line graph for date/time v Sub metering 3 data in blue
lines(strptime(powerdata$Timestamp, "%d/%m/%Y %H:%M:%S"), powerdata$Sub_metering_3, type = "l", col = "blue" )

#Adds legend to graph
legend("topright", lty= 1, col = c("Black", "red", "blue"), legend = c( "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#Chart3 
#this will be first graph in column 2
#Voltage on Y axis and date/time on X axis
plot(strptime(powerdata$Timestamp, "%d/%m/%Y %H:%M:%S"), powerdata$Voltage, type = "l", 
     xlab = "datetime", ylab = "Voltage")

#Chart 4
#this will be second graph in colun 2
#charting datetime v global reactive power
plot(strptime(powerdata$Timestamp, "%d/%m/%Y %H:%M:%S"), powerdata$Global_reactive_power, type = "l", 
     xlab = "datetime", ylab = "Global_reactive_power")
dev.off()