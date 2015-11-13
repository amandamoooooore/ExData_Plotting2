library(ggplot2)

# load the NEI and SCC data frames 
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

# only use the data that is related to vehicles
vehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehiclesSCC <- SCC[vehicles,]$SCC
vehiclesNEI <- NEI[NEI$SCC %in% vehiclesSCC,]

# filter NEI vehicle data to only include Baltimores fip and city name
vehiclesBaltimoreNEI <- vehiclesNEI[vehiclesNEI$fips=="24510",]
vehiclesBaltimoreNEI$city <- "Baltimore City"

# filter NEI vehicle data to only include LAs fip and city name
vehiclesLANEI <- vehiclesNEI[vehiclesNEI$fips=="06037",]
vehiclesLANEI$city <- "Los Angeles County"

# mergew both cities data into one data frame
bothNEI <- rbind(vehiclesBaltimoreNEI,vehiclesLANEI)

# define png
png("plot6.png",width=500,height=500,units="px")

# define plot
dataPlot <- ggplot(bothNEI, aes(x=factor(year), y=Emissions, fill=city)) +
        geom_bar(aes(fill=year),stat="identity") +
        facet_grid(scales="free", space="free", .~city) +
        labs(x="year", y=expression("Total PM"[2.5]*" Emission (Kilo-Tons)")) + 
        labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore & LA, 1999-2008")) +
        guides(fill=FALSE) 

# create plot
print(dataPlot)

# create png
dev.off()