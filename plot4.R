library(dplyr)
hpc <- read.table("household_power_consumption.txt", sep = ";", header = TRUE)
hpcdt <- tbl_df(hpc)
rm(hpc)

dates <- filter(hpcdt, as.character(Date) == "1/2/2007" | 
	   as.character(Date) == "2/2/2007")

dates <- mutate(dates, xtime = paste(Date, Time))

new_dates <- select(dates, Global_active_power:Voltage, 
		 Sub_metering_1:Sub_metering_3, xtime)

newtime <- strptime(new_dates$xtime, format = "%d/%m/%Y %H:%M:%S")

sm1 <- as.numeric(levels(new_dates$Sub_metering_1)[new_dates$Sub_metering_1])
sm2 <- as.numeric(levels(new_dates$Sub_metering_2)[new_dates$Sub_metering_2])
sm3 <- new_dates$Sub_metering_3

par(mfrow = c(2,2))

plot(newtime, as.numeric(levels(new_dates$Global_active_power)[new_dates$Global_active_power]), 
	   type = "l", ylab = "Global Active Power(Kilowatts)", xlab = '')

plot(newtime, as.numeric(levels(new_dates$Voltage)[new_dates$Voltage]), 
	   type = "l", ylab = "Voltage", xlab = "datetime")

with(new_dates, plot(newtime, sm1, type = "l", 
	xlab = '', ylab = "Energy sub metering" ))
with(new_dates, points(newtime, sm2, type = "l", col = "red"))
with(new_dates, points(newtime, sm3, type = "l", col = "blue"))
legend("topright", bty = "n", lty = 1, border = F, col = c("black", "red", "blue"), 
	legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
	cex = .75)

plot(newtime, as.numeric(levels(new_dates$Global_reactive_power)[new_dates$Global_reactive_power]), 
	   type = "l", ylab = "Global_reactive_power", xlab = "datetime", yaxt = 'n')
axis(2, at = seq(0.0,0.5,0.1), labels = seq(0,0.5,0.1))
	
dev.copy(png, file = "plot4.png")
dev.off()