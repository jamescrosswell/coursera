library("data.table")

# Read our household power consumption data in - this code is common to all plots
source("powerData.R")

# Write the plots out to a PNG device/file
png(file="plot4.png", height=480, width=480)

# Setup our base plot parameters for multiple plots (2 columns and 2 rows)
par(
  mfcol = c(2,2),
  mar = c(4,4,3,1),
  oma = c(0,0,0,0),
  cex.lab = 0.9,
  cex.axis = 0.9
)

with(dtPower,{

  # Create a line chart depicting the Global Active Power by hour
  plot(
    datetime, Global_active_power,
    type="l",
    xlab= "",
    ylab="Global Active Power"
  )

  # Create a line chart to visualise sub metering
  plot(datetime,Sub_metering_1,type="n", ylab="Energy sub metering", xlab= "")  
  lines(datetime,Sub_metering_1, col="black")
  lines(datetime,Sub_metering_2, col="red")
  lines(datetime,Sub_metering_3, col="blue")
  legend(
    "topright", 
    col=c("black","red","blue"), 
    legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
    lty = c(1, 1, 1),
    bty = "n",
    cex=0.9
  )

  # Create a line chart showing voltage by hour
  plot(
    datetime, Voltage,
    type="l",
    xlab= "datetime"
    
  )
  
  # Finally build a line chart showing global reacctive power by the hour
  plot(
    datetime, Global_reactive_power,
    type="l",
    xlab= "datetime",
    lwd=0.5
    
  )
  
})

# Finish writing the PNG file
dev.off()
