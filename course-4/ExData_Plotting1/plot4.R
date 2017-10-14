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

png("plot4.png")
par(mfrow=c(2,2))
plot(times,data$Global_active_power,ylab="Global Active Power (kilowatts)",type="l",xlab="")
plot(times,data$Voltage,xlab="datetime",ylab="Global Active Power (kilowatts)",type="l",col="black")
plot(times,data$Sub_metering_1,ylab="Energy sub metering",type="l",xlab="")
lines(times,data$Sub_metering_2,ylab="Energy sub metering",type="l",xlab="",col="red")
lines(times,data$Sub_metering_3,ylab="Energy sub metering",type="l",xlab="",col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=c(1,1,1))
plot(times,data$Global_reactive_power,xlab="datetime",ylab="Global_reactive_power",type="l",col="black")
dev.off()