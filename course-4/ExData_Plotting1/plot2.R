library(data.table)

setwd("/Users/William/Desktop/Desktop/Projects/coursera-dsc/course-4/ExData_Plotting1")

if(!dir.exists("./data")){
        dir.create("./data")
}


fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()
download.file(fileUrl,temp)
data <- fread(unzip(temp, "household_power_consumption.txt"), sep=";",na.strings="?", header=TRUE)
unlink(temp)

data$Date<-as.Date(data$Date,"%d/%m/%Y")

data<-data[(data$Date<=as.Date("2007-02-02")&data$Date>=as.Date("2007-02-01")),]

times<-strptime(paste(as.character(data$Date),data$Time),"%Y-%m-%d %H:%M:%S")

png("plot2.png")
plot(times,data$Global_active_power,ylab="Global Active Power (kilowatts)",type="l",xlab="")
dev.off()