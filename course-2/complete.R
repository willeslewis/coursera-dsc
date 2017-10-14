complete<-function(directory,id=1:332){
        #This function reports the number of complete entries for each monitor
        #in a data frame with monitor id and number of complete entries
        
        #directory is the location of the spectral data (input as string)
        #id is the set of monitor id's whose data we wish to consider
        
        #We must read in the files to a data frame and find the number of rows
        #that are complete cases
        
        #initialize a nobs vector
        nobs<-vector(mode="numeric",length=length(id))
        
        for(i in 1:length(id)){
                
                #id's must be 3 digits so preappend zeros if id is less than 100
                
                if(id[i]<10){
                        idmod<-paste("00",id[i],sep="")
                }else if(id[i]<100){
                        idmod<-paste("0",id[i],sep="")
                }else{
                        idmod<-id[i]
                }
                
                data<-read.csv(paste(directory,"/",idmod,".csv",sep=""))  
                
                #update the nobs vector
                nobs[i]<-sum(complete.cases(data))
                
        }
        
        compc<-as.data.frame(cbind(id,nobs))
        
        return(compc)
}