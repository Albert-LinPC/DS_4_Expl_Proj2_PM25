# Q2: Have total emissions from PM2.5 decreased
# in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008?
# Use the base plotting system to make a plot answering this question.

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")

library(dplyr)

Baltimore.yearly.emission <- filter(NEI, fips == "24510") %>%
                             group_by(year) %>%
                             summarise(yearly_emissions = sum(Emissions))

png("02_PM25_Baltimore.png", width = 480, height = 480, units = "px")

par(mar = c(5,5,4,2))
plot(x = Baltimore.yearly.emission$year,
     y = Baltimore.yearly.emission$yearly_emissions/1000,
     type = "l",
     xaxt = "n", yaxt = "n",
     xlab = "Year",
     ylab = expression("Total PM2.5 Emissions " ~ (10^3 ~ "tons")),
     ylim = c(0, 4)
)
axis(side = 1, at = seq(1999, 2008, 3), labels = seq(1999, 2008, 3))
axis(side = 2, at = seq(0, 4, 1), labels = seq(0, 4, 1))

dev.off()

