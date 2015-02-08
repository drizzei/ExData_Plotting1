library(dplyr)
hpc <- read.table("household_power_consumption.txt", sep = ";", header = TRUE)
hpcdt <- tbl_df(hpc)
rm(hpc)

dates <- filter(hpcdt, as.character(Date) == "1/2/2007" | 
	   as.character(Date) == "2/2/2007")

dates <- mutate(dates, xtime = paste(Date, Time))

new_dates <- select(dates, Sub_metering_1:Sub_metering_3, xtime)

newtime <- strptime(new_dates$xtime, format = "%d/%m/%Y %H:%M:%S")

sm1 <- as.numeric(levels(new_dates$Sub_metering_1)[new_dates$Sub_metering_1])
sm2 <- as.numeric(levels(new_dates$Sub_metering_2)[new_dates$Sub_metering_2])
sm3 <- new_dates$Sub_metering_3

with(new_dates, plot(newtime, sm1, type = "l", 
	xlab = '', ylab = "Energy sub metering" ))
with(new_dates, points(newtime, sm2, type = "l", col = "red"))
with(new_dates, points(newtime, sm3, type = "l", col = "blue"))

legend("topright", lty = 1, col = c("black", "red", "blue"), 
	legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
	cex = .75)

axis(2, at = seq(0,30,10), labels = seq(0,30,10))

dev.copy(png, file = "plot3.png")
dev.off()
