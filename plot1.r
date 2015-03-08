plot1 <- function() {
      
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

      
      png(file = "plot1.png")  
      
      # Produce the histogram using the base graphing
      hist(power$Global_active_power, col = "red",  xlab = "Global Active Power (kilowatts)", main ="")
      title("Global Active Power")
      
      dev.off()
}