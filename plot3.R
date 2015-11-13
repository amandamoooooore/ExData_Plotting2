library(ggplot2)

# load the NEI and SCC data frames 
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

# filter NEI data to only include Baltimores fip
baltimoreNEI <- NEI[NEI$fips=="24510",]

# aggregate using sum the Baltimore emissions data by year
aggTotalsBaltimore <- aggregate(Emissions ~ year, baltimoreNEI,sum)

# define png
png("plot3.png",width=500,height=500,units="px")

# define plot
dataPlot <- ggplot(baltimoreNEI,aes(factor(year),Emissions,fill=type)) +
        geom_bar(stat="identity") +
        facet_grid(.~type,scales = "free",space="free") + 
        labs(x="year", y=expression("Total PM"[2.5]*" Emission (Tons)")) + 
        labs(title=expression("PM"[2.5]*" Emissions, Baltimore City 1999-2008 by Source Type")) +
        guides(fill=FALSE)

# create plot
print(dataPlot)

# create png
dev.off()