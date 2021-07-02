# exploratory-data-analysis
project 2


Fine particulate matter (PM2.5) is an ambient air pollutant for which there is strong evidence that it is harmful to human health. In the United States, the Environmental Protection Agency (EPA) is tasked with setting national ambient air quality standards for fine PM and for tracking the emissions of this pollutant into the atmosphere. Approximatly every 3 years, the EPA releases its database on emissions of PM2.5. This database is known as the National Emissions Inventory (NEI). You can read more information about the NEI at the EPA National Emissions Inventory web site.

For each year and for each type of PM source, the NEI records how many tons of PM2.5 were emitted from that source over the course of the entire year. The data that you will use for this assignment are for 1999, 2002, 2005, and 2008.
Review criteria

For each question

    Does the plot appear to address the question being asked?
    Is the submitted R code appropriate for construction of the submitted plot?

Data

The data for this assignment are available from the course web site as a single zip file:

    Data for Peer Assessment [29Mb]

The zip file contains two files:

PM2.5 Emissions Data (summarySCC_PM25.rds\color{red}{\verb|summarySCC_PM25.rds|}summarySCC_PM25.rds): This file contains a data frame with all of the PM2.5 emissions data for 1999, 2002, 2005, and 2008. For each year, the table contains number of tons of PM2.5 emitted from a specific type of source for the entire year. Here are the first few rows.

1
2
3
4
5
6
7

    fips\color{red}{\verb|fips|}fips: A five-digit number (represented as a string) indicating the U.S. county
    SCC\color{red}{\verb|SCC|}SCC: The name of the source as indicated by a digit string (see source code classification table)
    Pollutant\color{red}{\verb|Pollutant|}Pollutant: A string indicating the pollutant
    Emissions\color{red}{\verb|Emissions|}Emissions: Amount of PM2.5 emitted, in tons
    type\color{red}{\verb|type|}type: The type of source (point, non-point, on-road, or non-road)
    year\color{red}{\verb|year|}year: The year of emissions recorded

Source Classification Code Table (Source_Classification_Code.rds\color{red}{\verb|Source_Classification_Code.rds|}Source_Classification_Code.rds): This table provides a mapping from the SCC digit strings in the Emissions table to the actual name of the PM2.5 source. The sources are categorized in a few different ways from more general to more specific and you may choose to explore whatever categories you think are most useful. For example, source “10100101” is known as “Ext Comb /Electric Gen /Anthracite Coal /Pulverized Coal”.

You can read each of the two files using the readRDS()\color{red}{\verb|readRDS()|}readRDS() function in R. For example, reading in each file can be done with the following code:

1
2
3

as long as each of those files is in your current working directory (check by calling dir()\color{red}{\verb|dir()|}dir() and see if those files are in the listing).
Assignment

The overall goal of this assignment is to explore the National Emissions Inventory database and see what it say about fine particulate matter pollution in the United states over the 10-year period 1999–2008. You may use any R package you want to support your analysis.
Questions

You must address the following questions and tasks in your exploratory analysis. For each question/task you will need to make a single plot. Unless specified, you can use any plotting system in R to make your plot.

    Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.
    Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510"\color{red}{\verb|fips == "24510"|}fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question.
    Of the four types of sources indicated by the type\color{red}{\verb|type|}type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.
    Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
    How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
    Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"\color{red}{\verb|fips == "06037"|}fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?

Making and Submitting Plots

For each plot you should

    Construct the plot and save it to a PNG file.
    Create a separate R code file (plot1.R\color{red}{\verb|plot1.R|}plot1.R, plot2.R\color{red}{\verb|plot2.R|}plot2.R, etc.) that constructs the corresponding plot, i.e. code in plot1.R constructs the plot1.png plot. Your code file should include code for reading the data so that the plot can be fully reproduced. You must also include the code that creates the PNG file. Only include the code for a single plot (i.e. plot1.R\color{red}{\verb|plot1.R|}plot1.R should only include code for producing plot1.png\color{red}{\verb|plot1.png|}plot1.png)
    Upload the PNG file on the Assignment submission page
    Copy and paste the R code from the corresponding R file into the text box at the appropriate point in the peer assessment.



QUESTION1

Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008. Upload a PNG file containing your plot addressing this question.
answer: yes they have decreased emissions through the years


Copy and paste the R code file for the plot uploaded in the previous question.


NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

png("plot1.png")

aggregatedTotal<- aggregate(Emissions ~ year, NEI, sum)

pts <- pretty(aggregatedTotal$Emissions/1000000);
yrs <- c(1999,2002,2005,2008)
plot(aggregatedTotal$year, aggregatedTotal$Emissions/1000000, type = "l", lwd = 2, axes = FALSE,
     xlab = "Year", 
     ylab = expression("Total Tons of PM"[2.5]*" Emissions"), 
     main = expression("Total Tons of PM"[2.5]*" Emissions in the United States"));
axis(1, at = yrs, labels = paste(yrs));
axis(2, at = pts, labels = paste(pts, "M", sep = ""));
box()
dev.off()

Question 2

Have total emissions from PM2.5 decreased in the  Baltimore City, Maryland ( fips == 24510\color{red}{\verb|fips == 24510|}fips == 24510) from 1999 to 2008? Use the base plotting system to make a plot answering this question.


answer: they have overall decreased
Prompt

Copy and paste the R code file for the plot uploaded in the previous question.

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


Question 3
Of the four types of sources indicated by the type\color{red}{\verb|type|}type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.


answer: all apart from point data type decrease emissions over time. The point data type increased from 1999- 2005 then decreased dramatically
Prompt

Copy and paste the R code file for the plot uploaded in the previous question.

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

Question 4
Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

answer: overall the emissions have decreased through the years
Prompt

Copy and paste the R code file for the plot uploaded in the previous question.

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
  
  Question 5

How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?


answer: Emissions from motor vehicle sources have dropped from 1999-2008 in Baltimore City for both road and non road data types
Prompt

Copy and paste the R code file for the plot uploaded in the previous question.

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
  
  
Question 6

Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == 06037\color{red}{\verb|fips == 06037|}fips == 06037). Which city has seen greater changes over time in motor vehicle emissions?

-answer: Los Angeles County has seen the greatest changes over time in motor vehicle emissions, they also have a much larger emissions every year than Baltimore
Prompt

Copy and paste the R code file for the plot uploaded in the previous question.

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
  
