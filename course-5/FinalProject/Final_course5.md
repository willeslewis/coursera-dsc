# Summary of Weather Event Impact on Economics and Heath
by willeslewis

This project will demonstrate to use of knitr to create a report.

## Synopsis


## Data Processing

In this step I don't do any preprocessing of the data.


```r
##load plyr
library(plyr)
library(data.table)

##Set current directory
workdir<-setwd("/Users/William/Desktop/Desktop/Projects/coursera-dsc/course-5/FinalProject")

mydat<-fread("data/StormData.csv",select = c("EVTYPE","FATALITIES","INJURIES","PROPDMG","CROPDMG"))

##Get sum of fatalaties injuries, property and crop damage for each event.
EventHealth<-ddply(mydat,.(EVTYPE),summarize,TotalFat=sum(FATALITIES),TotalInj=sum(INJURIES))
EventDMG<-ddply(mydat,.(EVTYPE),summarize,TotProp=sum(PROPDMG),TotCrop=sum(CROPDMG))

EventHealth$TotHealth<-EventHealth$TotalFat+EventHealth$TotalInj
EventDMG$TotDMG<-EventDMG$TotProp+EventDMG$TotCrop
OrderedHealth<-setorder(EventHealth,-TotHealth)
```

## Results

First I show a coarse histogram of the number of daily steps taken to get a sense of the distribution. To do this, tapply the sum function to the number of steps splitting over each date. NAs are ignored by the histogram. The default breaks value gives a decent sense of the distribution structure.

```r
        par(mfrow=c(1,3),mar=c(11,4,4,2))
        barplot(OrderedHealth$TotalFat[1:10],names.arg=OrderedHealth$EVTYPE[1:10],las=2)
        barplot(OrderedHealth$TotalInj[1:10],names.arg=OrderedHealth$EVTYPE[1:10],las=2)
        barplot(OrderedHealth$TotHealth[1:10],names.arg=OrderedHealth$EVTYPE[1:10],las=2)
```

![](Final_course5_files/figure-html/meandailysteps-1.png)<!-- -->
