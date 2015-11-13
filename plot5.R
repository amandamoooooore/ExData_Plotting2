library(ggplot2)

# load the NEI and SCC data frames 
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

# only use the data that is related to vehicles
vehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehiclesSCC <- SCC[vehicles,]$SCC
vehiclesNEI <- NEI[NEI$SCC %in% vehiclesSCC,]

# filter NEI vehicle data to only include Baltimores fip
baltimoreVehiclesNEI <- vehiclesNEI[vehiclesNEI$fips=="24510",]

# define png
png("plot5.png",width=500,height=500,units="px")

# define plot
dataPlot <- ggplot(baltimoreVehiclesNEI,aes(factor(year),Emissions)) +
        geom_bar(stat="identity",fill="grey",width=0.75) +
        labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 
        labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore from 1999-2008")) +
        guides(fill=FALSE) 

# create plot
print(dataPlot)

# create png
dev.off()