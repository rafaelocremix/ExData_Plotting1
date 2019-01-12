# loading the file
data <- read.table(file = "household_power_consumption.txt",
                   header = TRUE,
                   sep = ";",
                   quote = "",
                   dec = ".",
                   na.strings = "?",
                   colClasses = "character") # no trouble with factors

# mending the formats
head(data)
names(data)

## numbers as numbers
data[,3:9] <- sapply(data[,3:9], as.numeric)

## dates as.Date
data$Date <- as.Date(data$Date, "%d/%m/%Y")

## a posix date
data$t <- strptime(paste(data$Date, data$Time), "%Y-%m-%d %H:%M:%S", tz = "-03")

epc <- data[with(data,
                 Date >= "2007-02-01" &
                   Date <= "2007-02-02"), ]

with(epc, {
  png("plot3.png", width = 480, height = 480) # set device
  plot(x = t, y = epc[,7], type = "l", col = "Black", # master plot
       xlab = "",
       ylab = "Energy sub metering")
  lines(x = t, y = epc[,8], type = "l", col = "Red") # aditionals
  lines(x = t, y = epc[,9], type = "l", col = "Blue") # aditionals
  legend("topright", legend = schema[7:9], col = c("Black", "Red", "Blue"), pch = 16)
  dev.off() # record file
})
