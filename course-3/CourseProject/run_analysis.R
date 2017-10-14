## This script will create a data set from merging the UCI HAR Dataset 
## training and test data and then summarizing the mean of . The data contain
## subjectid: an integer describing to which subject the record is associated
## activity: a character describing the activity performed
## other variables: means of variables from the UCI dataset that are measurements on the mean and standard
## devitaion grouped by subjectid and activity (see CodeBook.md and ReadMe.md for more)

## clear the workspace
remove(list=ls())

## Load the relevant packages. (Please ensure the relevant packages are installed.)
library(data.table)

## Set directory to directory containing the data while saving old directory to return to later
olddir<-getwd()
dir<-"/Users/William/Desktop/Desktop/Projects/coursera-dsc/course-3/CourseProject"
setwd(dir)

## Import the test and train data and join row wise. Be sure to change
## file paths in fread() to those appropriate for your system. (can be achieved by changing dir above)
Xdat<- rbindlist(list(fread("./UCI HAR Dataset/train/X_train.txt"),fread("./UCI HAR Dataset/test/X_test.txt")))
Ydat<- rbindlist(list(fread("./UCI HAR Dataset/train/y_train.txt"),fread("./UCI HAR Dataset/test/y_test.txt")))
Subjectdat<- rbindlist(list(fread("./UCI HAR Dataset/train/subject_train.txt"),fread("./UCI HAR Dataset/test/subject_test.txt")))

## Import data to create activity names
activitydat<- fread("./UCI HAR Dataset/activity_labels.txt")

## Replace integers with activity names in Ydat
Ydat<-tolower(as.character(with(Ydat, factor(Ydat$V1, levels=activitydat$V1, labels=activitydat$V2))))

## Get feature names for Xdat
features<-fread("./UCI HAR Dataset/features.txt")

## Name columns in Xdat
names(Xdat)<-features$V2

#name subjectid as such
names(Subjectdat)<-"subjectid"

## Get a logic vector showing locations of measurements on the mean and standard deviation
ind<-grepl("-mean\\(\\)|-std\\(\\)",names(Xdat))

## Keep only measurements on the mean and std in Xdat
Xdat<-Xdat[,..ind]

## Enlarge xdat by cbinding subject and activity columns
Xdat<-cbind(Subjectdat,activity=Ydat,Xdat)

## Order the rows first on subjectid then on activity for ease of reading
Xdat<-Xdat[order(subjectid,desc(activity)),]

## Group the data by subjectid and activity for summarization
Groupdat<-group_by(Xdat,subjectid,activity)

## Summarize data grouped by subjectid and activity with the mean function
Groupdat<-summarize_all(Groupdat,mean)

## Write the data to a csv
##fwrite(Groupdat,file="summary_means_by_subject_and_activity.csv")

##Write the datat to a txt
write.table(Groupdat,file="summary_means_by_subject_and_activity.txt",row.names = FALSE)

## Return to original directory.
setwd(olddir)
