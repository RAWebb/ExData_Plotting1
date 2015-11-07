## Plot 4 script.  
##   script to create plot4 for Exploratory Data Analysis, project 1
##   see plot1.R for more verbose comments.
##   assumed data file household_power_consumption.txt has been downloaded & 
##   unzipped to working directory.  See plot1.R for instructions.

library(data.table)
library(dplyr)
library(lubridate)

pow <- read.table("household_power_consumption.txt", 
                  header=TRUE, sep=";", nrows=100000, na.strings = "?", 
                  stringsAsFactors = FALSE)
pow <- data.table(pow)
pow <- filter(pow, Date == "1/2/2007" | Date == "2/2/2007")
pow <- mutate(pow, DateTime = dmy_hms(paste(Date, Time, sep = " ")))
pow <- select(pow, DateTime, Global_active_power, Global_reactive_power, 
              Voltage, Global_intensity, Sub_metering_1, Sub_metering_2, 
              Sub_metering_3)

## Generate plot4.png:
png("plot4.png", height=480, width=480)

# Set display for 2x2 plot window:
par(mfrow = c(2,2))

## Generate 4 plots:
#top left
plot(pow$DateTime, pow$Global_active_power, type="l", xlab="", 
     ylab="Global Active Power (kilowatts)")

#top right
plot(pow$DateTime, pow$Voltage, type="l", xlab = "datetime", ylab="Voltage")

#bottom left
plot(pow$DateTime, pow$Sub_metering_1, type="l", 
     xlab="", ylab="Energy sub metering", col="black")
lines(pow$DateTime, pow$Sub_metering_2, type="l", col="red")
lines(pow$DateTime, pow$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lwd=2, col = c("black","red","blue"), bty="n")

#bottom right
plot(pow$DateTime, pow$Global_reactive_power, type="l", 
     xlab = "datetime", ylab="Global_reactive_power")


dev.off()