library(dplyr)
hpc <- read.table("household_power_consumption.txt", sep = ";", header = TRUE)
hpcdt <- tbl_df(hpc)
rm(hpc)

dates <- filter(hpcdt, as.character(Date) == "1/2/2007" | 
	   as.character(Date) == "2/2/2007")

dates <- mutate(dates, xtime = paste(Date, Time))

new_dates <- select(dates, Global_active_power, xtime)

newtime <- strptime(new_dates$xtime, format = "%d/%m/%Y %H:%M:%S")

plot(newtime, as.numeric(levels(new_dates$Global_active_power)[new_dates$Global_active_power]), 
	   type = "l", ylab = "Global Active Power(Kilowatts)", xlab = '')

dev.copy(png, file = "plot2.png")
dev.off()