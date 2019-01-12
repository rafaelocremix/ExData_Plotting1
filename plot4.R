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
  png("plot4.png", width = 480, height = 480) # set device
  par(mfrow = c(2, 2)) # setting a 2 x 2 grid

  # 1,1
  plot(x = t, y = Global_active_power, # x * y
       type = "l", # draw line instead of scatterplot
       ylab = "Global Active Power", # y axis title
       xlab = "" # make x axis title empity
  )

  # 1,2
  plot(x = t, y = Voltage, # x * y
       type = "l", # draw line instead of scatterplot
       ylab = "Voltage", # y axis title
       xlab = "dateime" # make x axis title empity
  )

  # 2,1
  plot(x = t, y = epc[,7], type = "l", col = "Black", # master plot
       xlab = "",
       ylab = "Energy sub metering")
  lines(x = t, y = epc[,8], type = "l", col = "Red") # aditionals
  lines(x = t, y = epc[,9], type = "l", col = "Blue") # aditionals
  legend("topright", legend = schema[7:9], col = c("Black", "Red", "Blue"), pch = 16)

  # 2,2
  plot(x = t, y = Global_reactive_power, # x * y
       type = "l", # draw line instead of scatterplot
       xlab = "dateime" # make x axis title empty # same mistakes!
  )
  dev.off() # record file
})
