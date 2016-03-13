library("data.table")

# Read our household power consumption data in - this code is common to all plots
source("powerData.R")

# Create a line chart to visualise sub metering
png("plot3.png", height=480, width=480)
with(dtPower,{
  plot(datetime,Sub_metering_1,type="n", ylab="Energy sub metering", xlab= "")  
  lines(datetime,Sub_metering_1, col="black")
  lines(datetime,Sub_metering_2, col="red")
  lines(datetime,Sub_metering_3, col="blue")
  legend(
    "topright", 
    col=c("black","red","blue"), 
    legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
    lty = c(1, 1, 1),
    cex=1
    )
})


# Copy the plot out to a PNG device/file
dev.off()
