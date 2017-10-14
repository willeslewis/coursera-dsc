rankall<-function(outcome,num="best"){
        ##This function will give the hospital names accross all states with rank 
        ## numbased on outcome e.g. "heart attack", "heart failure",
        ##or "pneumonia". The output is a data frame with hospital name and state 
        ## abbreviation
        
        ##state is a 2 letter string which is the state abbreviation
        ##outcome is one of the outcomes"heart attack", "heart failure",
        ##or pneumonia
        ##num is the rank of the hospital or the string "best"
        ## or the string "worst"
        
        allowedout<-c("heart attack","heart failure","pneumonia")
        ind<-c(11,17,23)
        
        outind<-ind[which(outcome==allowedout)]
        
        if(!(outcome %in% allowedout)){
                stop("invalid outcome")
        }
        
        ## read in the outcome-of-care csv
        data<-read.csv("outcome-of-care-measures.csv",colClasses = "character")
        
        ## split data by state to find each state with rank num
        data<-split(data,data$State)
        
        state<-names(data)
        
        hospital<-vector(mode="character",length=length(state))
        
        ##run ranking algorithm on each of the split data frames
        for(i in 1:length(state)){
                loopnum<-num
                
                ## keep the relevant subset to check for NAs
                subdata<-as.data.frame(data[i])
        
                ##keep relevant columns
                subdata<-subdata[,c(2,outind)]
        
                ##column 2 as numeric
                subdata[,2]<-as.numeric(subdata[,2])
        
                ## remove NAs
                subdata<-subdata[!is.na(subdata[,2]),]
        
                ## order by outcome and then
                ## hospital name and keep relevant column
                subdata<-subdata[order(subdata[,2],subdata[,1]),]
        
        
        
                ##return NA if num is too large
        
                if(is.character(loopnum)){
                        if(loopnum=="best"){loopnum<-1}
                        else if(loopnum=="worst"){
                                loopnum<-length(subdata[,1])}
                        else{
                                stop("invalid num character")
                        }
                }
                
                if(loopnum<=length(subdata[,1])){
                        hospital[i]<-as.character(subdata[,1][loopnum])
                }else{
                        hospital[i]<-NA
                }
                
        
        }
        
        ## get best hospital
        besthosp<-data.frame(hospital,state)
        return(besthosp)
}