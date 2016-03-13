library("data.table")

# Read our household power consumption data in - this code is common to all plots
source("powerData.R")

# Create a histogram showing the Global Active Power
hist(dtPower$Global_active_power, col="red", xlab="Global Active Power (kilowatts)")
title("Global Active Power")

# Copy the plot out to a PNG device/file
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()