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
png("plot3.png", width = 480, height = 480)

# Construct Plot 3: Sub metering lines
plot(
  df$DateTime,
  df$Sub_metering_1,
  type = "l",
  col = "black",
  xlab = "",
  ylab = "Energy sub metering",
  ylim =c(0,40)
)
lines(df$DateTime, df$Sub_metering_2, col = "red")
lines(df$DateTime, df$Sub_metering_3, col = "blue")

# Add Legend
legend(
  "topright",
  legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
  col = c("black", "red", "blue"),
  lty = 1
)

dev.off()