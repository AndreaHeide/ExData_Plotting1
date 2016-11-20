## Download and unzip data
file_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(file_url, destfile = "./household_power_consumption.zip", method = "curl", mode="wb")
unzip("household_power_consumption.zip")

## Read data
power_data <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?")
## Subset data to work with (1.2.2007 - 2.2.2007 ) 
data <- power_data[(as.Date(power_data$Date, format ="%d/%m/%Y") == "2007-02-01") | (as.Date(power_data$Date, format ="%d/%m/%Y") == "2007-02-02"), ]

## Plot 2
## glabal active power (kilowatts), date (day of the week)
png(filename = "plot2.png", width = 480, height = 480)

##plot(as.factor(weekdays(as.Date(data$Date), abbreviate = TRUE)), data$Global_active_power, type = "l")
## create column with date + time
library(lubridate)
data$NewDate <- mdy_hms(paste(data$Date, data$Time)) 
data$DateTime <- strptime(data$NewDate, format= "%Y-%d-%m %H:%M:%S")

## Set language to English and plot
Sys.setenv(LANG = "en")
options(warn = -1) 
plot(as.POSIXct(data$DateTime, "year-mday-mon hour:min:sec UTZ"), data$Global_active_power, type = "l", 
     xlab = "", ylab="Global Active Power (kilowatts)")
## (ignore warnings)
dev.off()
