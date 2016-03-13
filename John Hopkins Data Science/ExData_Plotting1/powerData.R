library("data.table")

# Read in the appropriate rows of the data set - we're only interested data for 1/2/2007 and 2/2/2007!
dtPower <- fread("household_power_consumption.txt", na.strings=c("?"), skip=66637, nrows=69517-66637)

# Since we skipped the header row we'll need to set the column names explicitly
setnames(dtPower, 1:9, c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Convert our character date/time columns to a POSIXct date/time format that is easier to work with
dtPower[,datetime:=as.POSIXct(strptime(paste(dtPower$Date, dtPower$Time), format = "%d/%m/%Y %H:%M:%S"))]

