library(ggplot2)

# load the NEI and SCC data frames 
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

# filter coal combustion related NEI data
combustionRelated <- grepl("comb", SCC$SCC.Level.One, ignore.case=TRUE)
coalRelated <- grepl("coal", SCC$SCC.Level.Four, ignore.case=TRUE) 
coalCombustion <- (combustionRelated & coalRelated)
combustionSCC <- SCC[coalCombustion,]$SCC
combustionNEI <- NEI[NEI$SCC %in% combustionSCC,]

# define png
png("plot4.png",width=500,height=500,units="px")

# define plot
dataPlot <- ggplot(combustionNEI,aes(factor(year),Emissions/10^5)) +
        geom_bar(stat="identity",fill="grey",width=0.75) +
        labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 
        labs(title=expression("PM"[2.5]*" Coal Combustion Source Emissions Across US from 1999-2008")) +
        guides(fill=FALSE) 

# create plot
print(dataPlot)

# create png
dev.off()