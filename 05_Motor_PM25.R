# How have emissions from motor vehicle sources changed
# from 1999–2008 in Baltimore City?

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(dplyr)
vehicles_SCC <- SCC[grep("Vehicles", SCC$EI.Sector), "SCC"]
NEI.Baltimore.vehicles <- filter(NEI, fips == "24510", SCC %in% vehicles_SCC) %>%
                          group_by(year) %>%
                          summarise(emissions = sum(Emissions))

png("05_Moter_PM25.png", width = 480, height = 480, units = "px")

plot(x = NEI.Baltimore.vehicles$year,
     y = NEI.Baltimore.vehicles$emissions,
     type = "l",
     xaxt = "n",
     xlab = "Year",
     ylab = "Total PM2.5 Emissions (tons)",
     ylim = c(0, 350)
    )
axis(side = 1, at = seq(1999, 2008, 3), labels = seq(1999, 2008, 3))

dev.off()