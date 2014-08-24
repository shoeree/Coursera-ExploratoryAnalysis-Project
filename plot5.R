## Author: Sterling Hoeree
## Purpose: Plot some PM2.5 data for the
## Coursera - Exploratory Data Analysis course project.

# Require ddply for easy split/transform/combine operations.
library(plyr)

# Require ggplot2
library(ggplot2)

# Read in the data.
data.NEI = readRDS("summarySCC_PM25.rds")

# Get only the "ON-ROAD" (i.e. cars, automobiles) rows.
data.onroad = data.NEI[data.NEI$type=="ON-ROAD",]

# Get the total emissions for the "ON-ROAD" type only for each year.
data.onroad = ddply(data.onroad, .(year),
                    summarize, total_emissions=sum(Emissions))

# Plot the total emissions for each year for on-road data.
plot5 = qplot(year, total_emissions, data=data.onroad,
              main="PM2.5 Emissions in Baltimore City, Maryland for Automobiles",
              xlab="Year", ylab="Total Emissions (PM2.5), In Tons",
              geom=c("point","line"))
print(plot5)

# Make the PNG
dev.copy(png, file="./plot5.png")
dev.off()
