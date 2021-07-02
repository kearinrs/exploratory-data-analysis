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



#4)Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
CombustionR <- grepl("comb", SCC$SCC.Level.One, ignore.case = TRUE)
CoalR <- grepl("coal", SCC$SCC.Level.Four, ignore.case = TRUE) 
coalcombustion <- (CombustionR & CoalR)
combustionSCC <- SCC[coalcombustion,]$SCC
combustionNEI <- NEI[NEI$SCC %in% combustionSCC,]

png("plot4.png")
ggplot(combustionNEI, aes(factor(year), Emissions, fill =  type)) +
  geom_bar(stat = "identity", width = 0.5) + 
  facet_grid(. ~ type, scales ="free",space="free") + 
  xlab("Year") +
  ylab(expression("Total Tons of PM"[2.5]*" Emissions")) + 
  ggtitle(expression("Total Tons PM"[2.5]*"Coal Combustion Source Emissions Across US from 1999-2008"))+
  theme(plot.title = element_text(hjust=1))+
  guides(fill = FALSE)
dev.off()

