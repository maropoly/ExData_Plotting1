mywd<- setwd("C:/Users/mrith/ExploratoryData")

library(data.table)
PowerData<- fread("household_power_consumption.txt", na.strings="?",stringsAsFactors = FALSE)


##power <- read.table(PowerData, header=T, sep=";") 
##does not work cause converted to fread()


power <- PowerData
## This is an added step to make power element of PowerData but I did cause 
## no way of knowing if I was going to use that fread again so it was
##it was my way of insuring 
##Important Date to put as.Date in correct format 

power$Date <- as.Date(power$Date, format="%d/%m/%Y")
df <- power[(power$Date=="2007-02-01") | (power$Date=="2007-02-02"),]
df$Global_active_power <- as.numeric(as.character(df$Global_active_power))
df$Global_reactive_power <- as.numeric(as.character(df$Global_reactive_power))
df$Voltage <- as.numeric(as.character(df$Voltage))
df <- transform(df, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")
df$Sub_metering_1 <- as.numeric(as.character(df$Sub_metering_1))
df$Sub_metering_2 <- as.numeric(as.character(df$Sub_metering_2))
df$Sub_metering_3 <- as.numeric(as.character(df$Sub_metering_3))

#plot 2

plot2 <- function() {
        plot(df$timestamp,df$Global_active_power, main=paste("Plot Range 02/01-02/02"), type="l", xlab="", ylab="Global Active Power (kilowatts)")
        dev.copy(png, file="plot2.png", width=480, height=480)
        dev.off()
        cat("plot2.png has been saved in", getwd())
}
plot2()

