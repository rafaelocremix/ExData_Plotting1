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
  png("plot1.png", width = 480, height = 480) # set graphics device
  hist(Global_active_power, # the source variable
       main = "Global Active Power", # title
       xlab = "Global Active Power (kilowatts)", # x label
       col = "Red", # fill colour
       ylim = c(0,1200), # y axis limit
       las = 1) # turn horizontal the y axis labels
  dev.off() # record file
})
