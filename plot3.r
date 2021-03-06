plot3 <- function() {
      
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
      
      png(file = "plot3.png")
            
      # Code for plot3 notice the use of line for the addtional lines the legend 
      plot(power$TimeAndDate, power$Sub_metering_1, type = "l", xlab = "", ylab = "Energy Sub Metering"  )
      lines(power$TimeAndDate, power$Sub_metering_2, col = "red" )
      lines(power$TimeAndDate, power$Sub_metering_3, col = "blue" )
      legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1,1), col=c("black", "blue","red"))
      
      dev.off()
      
}