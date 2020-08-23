# Read data files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

number.add.width<-800                             # width length to make the changes faster
number.add.height<-800                             # height length to make the changes faster

require(dplyr)

# Plot 3

require(ggplot2)

# Plot 3
# Group total NEI emissions per year:
baltcitymary.emissions.byyear<-summarise(group_by(filter(NEI, fips == "24510"), year,type), Emissions=sum(Emissions))

# clrs <- c("red", "green", "blue", "yellow")
ggplot(baltcitymary.emissions.byyear, aes(x=factor(year), y=Emissions, fill=type,label = round(Emissions,2))) + geom_bar(stat="identity") +
      facet_grid(. ~ type) +
      xlab("year") +
      ylab(expression("total PM"[2.5]*" emission in tons")) +
      ggtitle(expression("PM"[2.5]*paste(" emissions in Baltimore ", "City by various source types", sep="")))+
      geom_label(aes(fill = type), colour = "white", fontface = "bold")



