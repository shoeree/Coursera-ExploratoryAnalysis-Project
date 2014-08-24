# Require ddply for easy split/transform/combine operations.
library(plyr)

# Require ggplot2
library(ggplot2)

# Read in the data.
data.NEI = readRDS("summarySCC_PM25.rds")
data.SCC = readRDS("Source_Classification_Code.rds")

# Define BALTIMORE CITY as 24510.
BALTIMORE = 24510

# Subset only Baltimore City's PM2.5 data.
data.Baltimore = subset(data.NEI, data.NEI$fips==BALTIMORE)

# Plot the total emissions for each year in the data set using ggplot2.
data.Baltimore = ddply(data.Baltimore, .(year, type),
                       summarize, total_emissions=sum(Emissions))

plot3 = qplot(year, total_emissions, data=data.Baltimore,
              main="PM2.5 Emissions in Baltimore City, Maryland",
              xlab="Year", ylab="Total Emissions (PM2.5), In Tons",
              color=type, geom=c("point","smooth"))
print(plot3)

# Make the PNG
dev.copy(png, file="./plot3.png")
dev.off()
