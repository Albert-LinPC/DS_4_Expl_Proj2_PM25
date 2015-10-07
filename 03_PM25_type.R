# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable,
# which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City?
# Which have seen increases in emissions from 1999–2008?
# Use the ggplot2 plotting system to make a plot answer this question.

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")

library(dplyr)
NEI.Baltimore <- filter(NEI, fips == "24510") %>% group_by(type, year) %>%
                 summarise(emissions = sum(Emissions))

png("03_PM25_type.png", width = 800, height = 480, units = "px")

library(ggplot2)

g <- ggplot(NEI.Baltimore, aes(year, emissions))
g + scale_x_continuous(breaks=seq(1999,2008,3)) +
    facet_grid(. ~ type) +
    geom_line() + geom_point() +
    xlab("Year") +
    ylab("Total PM2.5 Emissions (tons)") +
    ggtitle("Emissions in Baltimore, Maryland") +
    theme(plot.title = element_text(lineheight=.8, face="bold"))


dev.off()