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

#2)Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510"\color{red}{\verb|fips == "24510"|}fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question.
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
png("plot2.png")
subNEI <- NEI[NEI$fips=="24510",]
baltimore <- aggregate(Emissions ~ year, subNEI, sum)

pts <- pretty(baltimore$Emissions/1000000);
yrs <- c(1999,2002,2005,2008)
plot(baltimore$year, baltimore$Emissions/1000000, type = "l", lwd = 2, axes = FALSE,
     xlab = "Year", 
     ylab = expression("Total Tons of PM"[2.5]*" Emissions"), 
     main = expression("Total Tons of PM"[2.5]*" Emissions From all Baltimore City Sources"));
axis(1, at = yrs, labels = paste(yrs));
axis(2, at = pts, labels = paste(pts, "M", sep = ""));
box()
dev.off()