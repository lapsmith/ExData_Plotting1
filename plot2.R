# Read full dataset using built-in base R
df <- read.table(
  "household_power_consumption.txt",
  header = TRUE,
  sep = ";",
  na.strings = "?",
  stringsAsFactors = FALSE
)

# Subset data for Feb 1, 2007 and Feb 2, 2007 (d/m/Y format in source file)
df <- df[df$Date %in% c("1/2/2007", "2/2/2007"), ]

# Convert Date and Time variables using strptime() and as.Date()
df$DateTime <- strptime(paste(df$Date, df$Time), format = "%d/%m/%Y %H:%M:%S")
df$Date <- as.Date(df$Date, format = "%d/%m/%Y")

# Open PNG device
png("plot2.png", width = 480, height = 480)

# Construct Plot 2: Time Series of Global Active Power
plot(
  df$DateTime,
  df$Global_active_power,
  type = "l",
  main= "Global Active Power",
  xlab = "",
  ylab = "Global Active Power (kilowatts)"
)

dev.off()
