## Code to make plot2.png

## Bring in packages
library(lubridate)

## Read in data
data_classes <- c("character", "character", rep("numeric", 7))
data1 <- read.table(unz("household_power_consumption.zip", "household_power_consumption.txt"), header=TRUE, sep = ";", colClasses = data_classes, na.strings = "?")
dates1 <- as.Date(data1[, 1], format = "%d/%m/%Y")
data1 <- data.frame(dates1, data1[, 2:ncol(data1)])
rm(dates1)
rm(data_classes)

## Slice data
date1 <- as.Date("01-02-2007", format = "%d-%m-%Y")
date2 <- as.Date("02-02-2007", format = "%d-%m-%Y")
data2 <- data1[data1[, 1] == date1 | data1[, 1] == date2, ]
rm(data1, date1, date2)

## Convert to dates and times
datetimes <- strptime(paste(data2[, 1], data2[, 2]), "%Y-%m-%d %H:%M:%S")
data3 <- data.frame(datetimes, data2[, 3:ncol(data2)])
rm(data2, datetimes)

## Create and save image
png(filename = "plot2.png", width = 480, height = 480, units = "px")
plot(data3$datetimes, data3$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")
dev.off()