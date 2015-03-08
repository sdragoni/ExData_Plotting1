plot4 <- function() {
      
      library(lubridate)
      
      # Read in the data and place into a data frame called powerAll - Reads file from the working directory
      powerAll <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")
      
      # Extract the records for the 1st and 2nd February 2007 and place in data frame power
      power <- powerAll[powerAll$Date %in% c("1/2/2007","2/2/2007"),]
      
      # Remove the large data frame - not strictly necessary. 
      rm(powerAll)
      
      # Convet the date and time fields from factors to character then combine and convert to date-time 
      power$Date <- as.character(power$Date)
      power$Time <- as.character(power$Time)
      DateTime <- paste(power$Date,power$Time)
      power$TimeAndDate <- dmy_hms(DateTime)
      
      # Remove any rows containing "?"
      power <- power[power$Global_active_power != "?",]
      
      # Conver the Global_active_power field from a factor to a character to a numeric
      power$Global_active_power <- as.numeric(as.character(power$Global_active_power))
      
      
      # End of common code
      
      png(file = "plot4.png")     
      
      # Code for plots 4
      par(mfrow = c(2,2))   # put 4 plots on the page
      
      # Plot 1
      plot(power$TimeAndDate, power$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power" )
      
      # Plot 2
      plot(power$TimeAndDate, power$Voltage, type = "l", xlab = "", ylab = "Voltage" )
      
      # Plot 3
      plot(power$TimeAndDate, power$Sub_metering_1, type = "l", xlab = "", ylab = "Energy Sub Metering"  )
      lines(power$TimeAndDate, power$Sub_metering_2, col = "red" )
      lines(power$TimeAndDate, power$Sub_metering_3, col = "blue" )
      legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1,1), col=c("black", "blue","red"))
      
      # Plot 4
      plot(power$TimeAndDate, power$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power" )
      
      dev.off()
}