## Author: Sterling Hoeree
## Purpose: Plot some PM2.5 data for the
## Coursera - Exploratory Data Analysis course project.

# Require ddply for easy split/transform/combine operations.
library(plyr)

# Read in the data.
data.NEI = readRDS("summarySCC_PM25.rds")
data.SCC = readRDS("Source_Classification_Code.rds")

# Plot the total emissions for each year in the data set.
data.total_emissions = ddply(data.NEI, .(year), 
                             summarize, total_emissions=sum(Emissions))

with(data.total_emissions, {
     plot(total_emissions ~ year, main="Total PM2.5 Emissions Per Year in the U.S.",
          xlab="Year", ylab="Total Emissions (PM2.5), In Tons", pch=20, col="blue")
     abline(lm(total_emissions ~ year), col="blue", lwd=2)
     })

# Make the PNG
dev.copy(png, file="./plot1.png")
dev.off()
