library(dplyr)
library(ggplot2)
library(scales)
library(data.table)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

head(NEI)
str(NEI)
head(SCC)
str(SCC)


#3)Of the four types of sources indicated by the type\color{red}{\verb|type|}type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
png("plot3.png")
subNEI <- NEI[NEI$fips=="24510",]
baltimore <- aggregate(Emissions ~ year, subNEI, sum)

pts <- pretty(baltimore$Emissions/1000000);
yrs <- c(1999,2002,2005,2008)


ggplot(subNEI, aes(factor(year), Emissions, fill = type)) + 
  geom_bar(stat = "identity") + 
  facet_grid(. ~ type, scales ="free",space="free") + 
  xlab("Year") + 
  ylab(expression("Total Tons of PM"[2.5]*" Emissions")) + 
  ggtitle(expression("Total Tons of PM"[2.5]*" Emissions in Baltimore by Source Type")) +
  theme(axis.text.x=element_text(angle = 90, vjust = 0.5, hjust = 1)) +
  
  guides(fill = FALSE)

dev.off()
