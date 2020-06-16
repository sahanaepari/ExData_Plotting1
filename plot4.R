household <- read.table("household_power_consumption.txt",sep = ';', 
                        header = TRUE, 
                        col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
                        colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))
household$Date <- as.Date(household$Date, "%d/%m/%Y")
household <- subset(household,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))
household <- household[complete.cases(household),] #removing ? data points

#creating DateTime column
dateTime <- paste(household$Date, household$Time)
dateTime <- setNames(dateTime, "DateTime")
household <- cbind(dateTime, household)
household <- household[ ,!(names(household) %in% c("Date","Time"))]
household$dateTime <- as.POSIXct(dateTime)

#plot4 code

par(mfrow=c(2,2), mar=c(4,4,1,1))

  plot(household$Global_active_power~household$dateTime, type="l", ylab = "Global Active Power", xlab = "")
  
  plot(household$Voltage~household$dateTime, type = "l", ylab = "Voltage", xlab="datetime")
  
  plot(household$Sub_metering_1~household$dateTime, type="l",ylab="Global Active Power", xlab="")
  lines(household$Sub_metering_2~household$dateTime,col='Red')
  lines(household$Sub_metering_3~household$dateTime,col='Blue')
  
  legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), 
         c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  
  plot(household$Global_reactive_power~household$dateTime, type = "l", xlab = "datetime")

  