library("data.table")

# Read our household power consumption data in - this code is common to all plots
source("powerData.R")

# Create a line chart depicting the Global Active Power by hour
plot(
  dtPower$datetime,dtPower$Global_active_power,
  type="l",
  xlab= "",
  ylab="Global Active Power (killowatts)"
  )

# Copy the plot out to a PNG device/file
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()
