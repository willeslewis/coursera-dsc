##Load needed libraries
library(ggplot2)
library(plyr)


##Set current directory
workdir<-setwd("/Users/William/Desktop/Desktop/Projects/coursera-dsc/course-4/Emission_Exploration_Project")

##Make a directory to hold the data if there isn't already one.
if(!dir.exists(paste(workdir,"/data",sep=""))){
        dir.create(paste(workdir,"/data",sep=""))
}


##Download the zip file and extract it to the data folder
##if for some reason it is not already in the
##working directory or if the data is not already extracted.
if(!file.exists("data/Source_Classification_Code.rds") || !file.exists("data/summarySCC_PM25.rds")){
        fileUrl<- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip";
        temp <- tempfile()
        download.file(fileUrl,temp,method="curl")
        unzip(temp,exdir="data")
        unlink(temp)
}

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")
MotorSCC<-SCC$SCC[sapply(as.character(SCC$EI.Sector),grepl,pattern="^Mobile - On-Road",perl=TRUE,USE.NAMES=FALSE)]
PM25tots<-NEI[(NEI$fips=="24510"|NEI$fips=="06037")&NEI$SCC %in% MotorSCC,]
PM25sum<-ddply(PM25tots,.(year,fips),summarize,total=sum(Emissions))
PM25sum$fips<-as.factor(PM25sum$fips)
levels(PM25sum$fips)[levels(PM25sum$fips)=="06037"] <- "LA"
levels(PM25sum$fips)[levels(PM25sum$fips)=="24510"] <- "Baltimore"

qplot(year,total,data=PM25sum,facets=.~fips,main="Total motor vehicle emissions in LA (left) and Baltimore (right)",ylab="Total in tons")
ggsave("plot6.png")