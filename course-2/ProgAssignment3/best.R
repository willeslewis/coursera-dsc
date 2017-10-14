best<-function(state,outcome){
        ##This function will give the best hospital in a state
        ##based on outcome e.g. "heart attack", "heart failure",
        ##or pneumonia.
        
        ##state is a 2 letter string which is the state abbreviation
        ##outcome is one of the outcomes"heart attack", "heart failure",
        ##or pneumonia

        allowedout<-c("heart attack","heart failure","pneumonia")
        ind<-c(11,17,23)
        
        outind<-ind[which(outcome==allowedout)]
        
        if(!(outcome %in% allowedout)){
                stop("invalid outcome")
        }
        
        ## read in the outcome-of-care csv
        data<-read.csv("outcome-of-care-measures.csv",colClasses = "character")
        
        if(!(state %in% data$State)){
                stop("invalid state")
               
               
                
                
        }else{ ## keep the relevant subset to check for NAs
                subdata<-data[data$State==state,]
                
                ## order by hospital name and keep relevant column
                subdata<-subdata[order(subdata$Hospital.Name),]
                
                subdata<-subdata[,c(2,outind)]
                
                #make column 2 numeric
                subdata[,2]<-as.numeric(subdata[,2])
                
                subdata<-subdata[!is.na(subdata[,2]),]
 
                
                ## get best hospital
                besthosp<-as.character(subdata$Hospital.Name[which.min(subdata[,2])])
                
        }
        return(besthosp)
        
}