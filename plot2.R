## Plot 2 script.  
##   script to create plot2 for Exploratory Data Analysis, project 1
##   see plot1.R for more verbose comments.
##   assumed data file household_power_consumption.txt has been downloaded & 
##   unzipped to working directory.   See plot1.R for instructions.

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

## Generate plot2.png:
png("plot2.png", height=480, width=480)
plot(pow$DateTime, pow$Global_active_power, type="l", xlab="", 
     ylab="Global Active Power (kilowatts)")
dev.off()
