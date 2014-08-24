# Require ddply for easy split/transform/combine operations.
library(plyr)

# Require ggplot2
library(ggplot2)

# Read in the data.
data.NEI = readRDS("summarySCC_PM25.rds")

# Define some fips codes.
BALTIMORE = "24510"
LOS_ANGELES = "06037"

# Subset only Baltimore City's PM2.5 data.
data.cities = subset(data.NEI, data.NEI$fips==BALTIMORE | data.NEI$fips==LOS_ANGELES)

# Get only the "ON-ROAD" (i.e. cars, automobiles) rows.
data.cities = data.cities[data.cities$type=="ON-ROAD",]
data.cities.onroad$fips = factor(data.cities.onroad$fips)

# Get the total emissions for the "ON-ROAD" type only for each year.
data.cities.onroad = ddply(data.cities, .(year, fips),
                           summarize, total_emissions=sum(Emissions))

# Join the fips column with the actual city names.
cities = data.frame(fips=c(BALTIMORE, LOS_ANGELES),
                    city_name=c("BALTIMORE CITY, ATLANTA", 
                                "LOS ANGELES COUNTY, CALIFORNIA"))
data.cities.onroad = merge(x=data.cities.onroad, y=cities,
                           by.x="fips", by.y="fips", all=TRUE)

# Plot the total emissions for each year for on-road data.
plot6 = qplot(year, total_emissions, data=data.cities.onroad,
              main="PM2.5 Emissions relating to Automobiles",
              xlab="Year", ylab="Total Emissions (PM2.5), In Tons",
              color=city_name, geom=c("point","line"))
print(plot6)

# Make the PNG
dev.copy(png, file="./plot6.png")
dev.off()
