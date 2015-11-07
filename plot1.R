## Plot 1 script.  
##   script to create plot1 for Exploratory Data Analysis, project 1
##
##If packages are not installed on system:  uncomment and execute the following:
#install.packages(c("lubridate", "dplyr", "data.table"))

library(data.table)
library(dplyr)
library(lubridate)


## Download & unzip the file linked in the README.md to working directory
##      Or uncomment and run the following R commands:
#download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
#              "household_power_consumption.zip")
#unzip("household_power_consumption.zip")



## relevant data starts at line 66638  and is 2880 in length  so one option is 
##      is to use skip=66636 (makes 66637 header) and nrows=2880 in the read.table
##      command but this creates slight difficulties w/ variable names and isn't
##      robust if the data set changes slightly.
##
## So instead just read in first 100000 lines, this includes the desired dates

pow <- read.table("household_power_consumption.txt", 
                  header=TRUE, sep=";", nrows=100000, na.strings = "?", 
                  stringsAsFactors = FALSE)
# Convert to data.table
pow <- data.table(pow)
#extract dates of interest
pow <- filter(pow, Date == "1/2/2007" | Date == "2/2/2007")

#Convert strings for Date & Time to POSIX datetime & reorganize pow 
pow <- mutate(pow, DateTime = dmy_hms(paste(Date, Time, sep = " ")))

pow <- select(pow, DateTime, Global_active_power, Global_reactive_power, 
              Voltage, Global_intensity, Sub_metering_1, Sub_metering_2, 
              Sub_metering_3)

## Generate Plot 1 in png file:
png("plot1.png", height=480, width=480)
hist(pow$Global_active_power, col="red", main="Global Active Power", 
     xlab="Global Active Power (kilowatts)")
dev.off()
