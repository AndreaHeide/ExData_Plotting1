## Download and unzip data
file_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(file_url, destfile = "./household_power_consumption.zip", method = "curl", mode="wb")
unzip("household_power_consumption.zip")

## Read data
power_data <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?")
## Subset data to work with (1.2.2007 - 2.2.2007 ) 
data <- power_data[(as.Date(power_data$Date, format ="%d/%m/%Y") == "2007-02-01") | (as.Date(power_data$Date, format ="%d/%m/%Y") == "2007-02-02"), ]


## Plot 3
## energy sub metering 1,2,3
png(filename = "plot3.png", width = 480, height = 480)

## create column with date + time
library(lubridate)
data$NewDate <- mdy_hms(paste(data$Date, data$Time)) 
data$DateTime <- strptime(data$NewDate, format= "%Y-%d-%m %H:%M:%S")

## Create empty plot first
options(warn = -1) 
plot(as.POSIXct(data$DateTime, "year-mday-mon hour:min:sec UTZ"), data$Sub_metering_1, type = "n", 
     xlab = "", ylab="Energy Sub Metering")
points(as.POSIXct(data$DateTime, "year-mday-mon hour:min:sec UTZ"), data$Sub_metering_1, type = "l")
points(as.POSIXct(data$DateTime, "year-mday-mon hour:min:sec UTZ"), data$Sub_metering_2, type = "l", col = "red")
points(as.POSIXct(data$DateTime, "year-mday-mon hour:min:sec UTZ"), data$Sub_metering_3, type = "l", col = "blue")
legend("topright", lty=c(1,1), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
## (ignore warnings)
dev.off()