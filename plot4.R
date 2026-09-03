 
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
png("plot4.png", width = 3840, height = 2160)

# Configure 2x2 grid
par(mfrow = c(2, 2))

# Top-Left: Global Active Power
plot(df$DateTime, df$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")

# Top-Right: Voltage
plot(df$DateTime, df$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

# Bottom-Left: Sub Metering
plot(df$DateTime, df$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(df$DateTime, df$Sub_metering_2, col = "red")
lines(df$DateTime, df$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1, bty = "n")

# Bottom-Right: Global Reactive Power
plot(df$DateTime, df$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")

dev.off()