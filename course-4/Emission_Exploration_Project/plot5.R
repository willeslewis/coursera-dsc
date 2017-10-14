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

#Get subset of the data from Baltimore county for motor vehicles
MotorSCC<-SCC$SCC[sapply(as.character(SCC$EI.Sector),grepl,pattern="^Mobile - On-Road",perl=TRUE,USE.NAMES=FALSE)]
PM25tots<-tapply(NEI$Emissions[NEI$SCC %in% MotorSCC & NEI$fips=="24510"],NEI$year[NEI$SCC %in% MotorSCC & NEI$fips=="24510"],sum,na.rm=TRUE)
png("plot5.png")
plot(as.integer(names(PM25tots)),PM25tots,type="l",main="Total PM2.5 Emissions in Baltimore from Motor Vehicles vs Year",xlab="Year",ylab="Total emissions in Tons")
points(as.integer(names(PM25tots)),PM25tots, cex = 2, col = "red")
dev.off()