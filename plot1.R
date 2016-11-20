## Download and unzip data
file_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(file_url, destfile = "./household_power_consumption.zip", method = "curl", mode="wb")
unzip("household_power_consumption.zip")

## Read data
power_data <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?")
## Subset data to work with (1.2.2007 - 2.2.2007 ) 
data <- power_data[(as.Date(power_data$Date, format ="%d/%m/%Y") == "2007-02-01") | (as.Date(power_data$Date, format ="%d/%m/%Y") == "2007-02-02"), ]


## Plot 1
png(filename = "plot1.png", width = 480, height = 480)
hist(data$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylim = c(0, 1200))
dev.off()