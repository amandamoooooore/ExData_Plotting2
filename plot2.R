# load the NEI and SCC data frames 
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

# filter NEI data to only include Baltimores fip
baltimoreNEI <- NEI[NEI$fips=="24510",]

# aggregate using sum the Baltimore emissions data by year
aggTotalsBaltimore <- aggregate(Emissions ~ year, baltimoreNEI,sum)

# define png
png("plot2.png",width=500,height=500,units="px")

# create barplot
barplot(
        aggTotalsBaltimore$Emissions,
        names.arg=aggTotalsBaltimore$year,
        xlab="Year",
        ylab="PM2.5 Emissions (Tons)",
        main="Total PM2.5 Emissions From all Baltimore City Sources"
)

# create png
dev.off()