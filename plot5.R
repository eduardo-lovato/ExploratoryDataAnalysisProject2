# Read data files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

number.add.width<-800                             # width length to make the changes faster
number.add.height<-800                             # height length to make the changes faster


baltcitymary.emissions<-NEI[(NEI$fips=="24510") & (NEI$type=="ON-ROAD"),]
require(dplyr)
baltcitymary.emissions.byyear <- summarise(group_by(baltcitymary.emissions, year), Emissions=sum(Emissions))
require(ggplot2)
ggplot(baltcitymary.emissions.byyear, aes(x=factor(year), y=Emissions,fill=year, label = round(Emissions,2))) +
      geom_bar(stat="identity") +
      xlab("year") +
      ylab(expression("total PM"[2.5]*" emissions in tons")) +
      ggtitle("Emissions from motor vehicle sources in Baltimore City")+
      geom_label(aes(fill = year),colour = "white", fontface = "bold")

