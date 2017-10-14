rankhospital<-function(state,outcome,num="best"){
        ##This function will give the hospital in a state with rank num
        ##based on outcome e.g. "heart attack", "heart failure",
        ##or "pneumonia".
        
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
        
        if(!(state %in% data$State)){
                stop("invalid state")
                
                
                
                
        }else{ ## keep the relevant subset to check for NAs
                subdata<-data[data$State==state,]
                
                ##keep relevant columns
                subdata<-subdata[,c(2,outind)]
                
                ##column 2 as numeric
                subdata[,2]<-as.numeric(subdata[,2])
                
                ## remove NAs
                subdata<-subdata[!is.na(subdata[,2]),]
                
                ## order by outcome and then
                ## hospital name and keep relevant column
                subdata<-subdata[order(subdata[,2],subdata$Hospital.Name),]
                

                
                ##return NA if num is too large
                
                if(is.character(num)){
                        if(num=="best"){num<-1}
                        else if(num=="worst"){
                                num<-length(subdata$Hospital.Name)}
                        else{
                                stop("invalid num character")
                        }
                }else if(num>length(subdata$Hospital.Name)){
                        return(NA)
                        stop()
                }
                
                ## get best hospital
                besthosp<-as.character(subdata$Hospital.Name[num])
                
        }
        return(besthosp)
        
}