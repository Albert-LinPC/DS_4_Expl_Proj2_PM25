# Across the United States,
# how have emissions from coal combustion-related sources changed from 1999–2008?

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(dplyr)
coal_related_SCC <- SCC[grep("Coal", SCC$EI.Sector), "SCC"]
NEI.coal <- filter(NEI, SCC %in% coal_related_SCC) %>%
            group_by(year) %>%
            summarise(emissions = sum(Emissions))


png("04_CoalCombustion_PM25.png", width = 480, height = 480, units = "px")

par(mar = c(5,5,4,2))
plot(x = NEI.coal$year,
     y = NEI.coal$emissions/100000,
     type = "l",
     xaxt = "n", yaxt = "n",
     xlab = "Year",
     ylab = expression("Total PM2.5 Emissions " ~ (10^5 ~ "tons")),
     ylim = c(0, 6)
)
axis(side = 1, at = seq(1999, 2008, 3), labels = seq(1999, 2008, 3))
axis(side = 2, at = seq(0, 6, 2), labels = seq(0, 6, 2))

dev.off()