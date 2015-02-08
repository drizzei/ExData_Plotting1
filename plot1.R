library(dplyr)
hpc <- read.table("household_power_consumption.txt", sep = ";", header = TRUE)
hpcdt <- tbl_df(hpc)
rm(hpc)

dates <- filter(hpcdt, as.character(Date) == "1/2/2007" | 
	   as.character(Date) == "2/2/2007")




hist(as.numeric(levels(dates$Global_active_power)[dates$Global_active_power]),
	xlab = "Global Active Power(Kilowatts)", col = "red", main = "Global Active Power")

axis(1, at = seq(0,6,2), labels = seq(0,6,2))
axis(2, at = seq(0,1200,200), labels = seq(0,1200,200))

dev.copy(png, file = "plot1.png")
dev.off()