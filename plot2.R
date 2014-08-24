# Require ddply for easy split/transform/combine operations.
library(plyr)

# Read in the data.
data.NEI = readRDS("summarySCC_PM25.rds")
data.SCC = readRDS("Source_Classification_Code.rds")

# Define BALTIMORE CITY as 24510.
BALTIMORE = 24510

# Subset only Baltimore City's PM2.5 data.
data.Baltimore = subset(data.NEI, data.NEI$fips==BALTIMORE)

# Plot the total emissions for each year in the data set.
data.Baltimore = ddply(data.Baltimore, .(year),
                       summarize, total_emissions=sum(Emissions))

with(data.Baltimore, {
  plot(total_emissions ~ year, main="Total PM2.5 Emissions Per Year in Baltimore City, Maryland",
       xlab="Year", ylab="Total Emissions (PM2.5), In Tons", pch=20, col="blue")
  abline(lm(total_emissions ~ year), col="blue", lwd=2)
})

# Make the PNG
dev.copy(png, file="./plot2.png")
dev.off()
