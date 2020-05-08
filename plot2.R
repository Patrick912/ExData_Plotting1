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
png(filename = "plot2.png")
plot(data$DateTime, data$Global_active_power, type = "l", xlab ="", ylab="Global Active Power (kw)")
dev.off()