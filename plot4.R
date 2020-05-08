library(lubridate)
library(dplyr)

loaddata <- function(download) {
    if (download) {
        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "pc.zip")
        unzip("pc.zip")
    }
    classes <- c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric")
    data <- read.csv("household_power_consumption.txt", sep = ";", colClasses = classes, na.strings = c("?"))
    
    data <- data %>% as_tibble() %>% 
        filter( Date == "1/2/2007" | Date == "2/2/2007") %>%
        mutate( "DateTime" = dmy_hms(paste(Date,Time))) %>%
        select(-Date, -Time)
    data   
}

data<- loaddata(TRUE)


png(filename = "plot4.png")
par(mfrow = c(2,2))
#upper left
plot(data$DateTime, data$Global_active_power, type = "l", xlab ="", ylab="Global Active Power (kw)")
#upper right
plot(data$DateTime, data$Voltage, type = "l", xlab ="datetime", ylab="Voltage")
#lower left
plot(data$DateTime,data$Sub_metering_1, type = "n", xlab ="", ylab="Energy sub metering")
points(data$DateTime,data$Sub_metering_1, type ="l")
points(data$DateTime,data$Sub_metering_2, type ="l", col = "red")
points(data$DateTime,data$Sub_metering_3, type ="l", col = "blue")
legend("topright", col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       lty=c(1,1), bty ="n")
#lower right
plot(data$DateTime, data$Global_reactive_power, type = "l", xlab ="datetime", ylab="Global_reactive_power")
dev.off()
