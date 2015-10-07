# Compare emissions from motor vehicle sources in Baltimore City
# with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037").
# Which city has seen greater changes over time in motor vehicle emissions?

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(dplyr)
vehicles_SCC <- SCC[grep("Vehicles", SCC$EI.Sector), "SCC"]
NEI.vehicles <- filter(NEI, fips == "24510" | fips == "06037",
                       SCC %in% vehicles_SCC) %>%
                group_by(year, fips) %>%
                summarise(emissions = sum(Emissions))

png("06_Vehicles_BA_CA_PM25.png", width = 480, height = 480, units = "px")

library(ggplot2)
NEI.vehicles$city <- "Baltimore"
NEI.vehicles[NEI.vehicles$fips == "06037", "city"] <- "Los Angeles"
g <- ggplot(NEI.vehicles, aes(x = year, y = emissions))
g + facet_grid(. ~ city) +
    geom_point() + geom_line() +
    xlab("Year") +
    ylab("Total PM2.5 Emissions (tons)") +
    scale_x_continuous(breaks=seq(1999,2008,3))

dev.off()