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


#6) Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"\color{red}{\verb|fips == "06037"|}fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
motors<- grepl("vehicle", SCC$SCC.Level.Two, ignore.case = TRUE)
motorsSCC <-  SCC[motors,]$SCC
motorsNEI <- NEI[NEI$SCC %in% motorsSCC,]


subNEIBalt <- motorsNEI[motorsNEI$fips=="24510",]
subNEIBalt$city <- "Baltimore City"


subNEILA <- motorsNEI[motorsNEI$fips=="06037",]
subNEILA$city <- "Los Angeles County"

bothNEI <- rbind(subNEIBalt, subNEILA)

png("plot6.png")

ggplot(bothNEI, aes(factor(year), Emissions, fill = city)) + 
  geom_bar(aes(fill=year),stat = "identity") + 
  facet_grid(. ~ city, scales ="free",space="free") + 
  xlab("Year") + 
  ylab(expression("Total Tons of PM"[2.5]*" Emissions")) + 
  ggtitle(expression("Total Tons PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore & LA, 1999-2008"))+
  theme(plot.title = element_text(hjust = 1)) +
  
  guides(fill = FALSE)
dev.off()




