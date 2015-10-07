# Q1: Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
# Using the base plotting system,
# make a plot showing the total PM2.5 emission
# from all sources for each of the years 1999, 2002, 2005, and 2008.

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")

library(dplyr)

by_year <- group_by(NEI, year)
yearly_emission <- summarize(by_year, ttl_emission = sum(Emissions))

png("01_TTL_PM25.png", width = 480, height = 480, units = "px")

par(mar = c(5,5,4,2))
plot(x = yearly_emission$year,
     y = yearly_emission$ttl_emission/1000000,
     type = "l",
     xaxt = "n", yaxt = "n",
     xlab = "Year",
     ylab = expression("Total PM2.5 Emissions " ~ (10^6 ~ "tons")),
     ylim = c(0, 8)
     )
axis(side = 1, at = seq(1999, 2008, 3), labels = seq(1999, 2008, 3))
axis(side = 2, at = seq(0, 8, 2), labels = seq(0, 8, 2))

dev.off()
