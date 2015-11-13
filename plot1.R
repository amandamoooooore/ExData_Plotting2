# load the NEI and SCC data frames 
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

# aggregate by sum the total emissions by year
aggTotals <- aggregate(Emissions ~ year, NEI, sum)

# define png
png("plot1.png",width=500,height=500,units="px")

# create barplot
barplot(
        (aggTotals$Emissions)/10^6,
        names.arg=aggTotals$year,
        xlab="Year",
        ylab="PM2.5 Emissions (10^6 Tons)",
        main="Total PM2.5 Emissions From All US Sources"
)

# create png
dev.off()