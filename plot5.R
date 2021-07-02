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



#5) How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
motors<- grepl("vehicle", SCC$SCC.Level.Two, ignore.case = TRUE)
motorsSCC <-  SCC[motors,]$SCC
motorsNEI <- NEI[NEI$SCC %in% motorsSCC,]


subNEI <- motorsNEI[motorsNEI$fips=="24510",]

png("plot5.png")

ggplot(subNEI, aes(factor(year), Emissions, fill = type)) + 
  geom_bar(stat = "identity") + 
  facet_grid(. ~ type, scales ="free",space="free") + 
  xlab("Year") + 
  ylab(expression("Total Tons of PM"[2.5]*" Emissions")) + 
  ggtitle(expression("Total Tons of PM"[2.5]*" Emissions in Baltimore, 1999-2008")) +
  theme(axis.text.x=element_text(angle = 90, vjust = 0.5, hjust = 1)) +
  
  guides(fill = FALSE)
dev.off()


