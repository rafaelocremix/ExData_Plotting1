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

# merge Date + Time into a continous time variable t
# epc$t <- strptime(paste(epc$Date, epc$Time), "%Y-%m-%d %H:%M:%S", tz = "-03")

with(epc, {
  png("plot2.png", width = 480, height = 480) # set devide
  plot(x = t, y = Global_active_power, # x * y
       type = "l", # draw line instead of scatterplot
       ylab = "Global Active Power (kilowatt)", # y axis title
       xlab = "" # make x axis title empity
  )
  dev.off() # record file
})
