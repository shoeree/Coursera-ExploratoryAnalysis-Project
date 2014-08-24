# Require ddply for easy split/transform/combine operations.
library(plyr)

# Require ggplot2
library(ggplot2)

# Read in the data.
data.NEI = readRDS("summarySCC_PM25.rds")
data.SCC = readRDS("Source_Classification_Code.rds")

# Find only those pollutant types which are "coal"-related.
coal_scc_idx = grep("[Cc]oal", data.SCC$Short.Name)
coal_scc = data.SCC[coal_scc_idx,c("SCC", "SCC.Level.Four")]

# Get only the NEI data for Coal-type pollutants.
data.coal = data.NEI[data.NEI$SCC %in% coal_scc$SCC,]

# Get the total emissions for each of the coal types for each year.
data.coal = ddply(data.coal, .(year),
                  summarize, total_emissions=sum(Emissions))

# Plot the total emissions for each year.
plot4 = qplot(year, total_emissions, data=data.coal,
              main="PM2.5 Emissions in the U.S. for Combustible Coal",
              xlab="Year", ylab="Total Emissions (PM2.5), In Tons",
              geom=c("point","line"))
print(plot4)

# Make the PNG
dev.copy(png, file="./plot4.png")
dev.off()
