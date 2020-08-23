# Read data files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

number.add.width<-800                             # width length to make the changes faster
number.add.height<-800                             # height length to make the changes faster

require(dplyr)
baltcitymary.emissions<-summarise(group_by(filter(NEI, fips == "24510"& type == 'ON-ROAD'), year), Emissions=sum(Emissions))
losangelscal.emissions<-summarise(group_by(filter(NEI, fips == "06037"& type == 'ON-ROAD'), year), Emissions=sum(Emissions))

baltcitymary.emissions$County <- "Baltimore City, MD"
losangelscal.emissions$County <- "Los Angeles County, CA"
both.emissions <- rbind(baltcitymary.emissions, losangelscal.emissions)

require(ggplot2)
ggplot(both.emissions, aes(x=factor(year), y=Emissions, fill=County,label = round(Emissions,2))) +
      geom_bar(stat="identity") + 
      facet_grid(County~., scales="free") +
      ylab(expression("total PM"[2.5]*" emissions in tons")) + 
      xlab("year") +
      ggtitle(expression("Motor vehicle emission variation in Baltimore and Los Angeles in tons"))+
      geom_label(aes(fill = County),colour = "white", fontface = "bold")


