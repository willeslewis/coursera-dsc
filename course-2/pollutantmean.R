pollutantmean<-function(directory,pollutant,id=1:332){
        #This function calculates the mean of pollutant across all monitors
        # with idenity given by id
        
        #directory is the location of the spectral data (input as string)
        #pollutant is either sulfate or nitrate (input as string)
        #id is the set of monitor id's whose data we wish to consider
        
        #We must read in the files to a data frames and calculate the mean of
        #the desired pollutant over all monitors.
        
        #initialize summed pollutant value (total) and number of numeric entries
        #(nsamp)
        total<-0
        nsamp<-0
        
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
                
                #update the numerator
                total<-total+sum(data[[pollutant]],na.rm=TRUE)
                
                #update the denominator
                nsamp<-nsamp+sum(!is.na(data[[pollutant]]))
                
        }
        
        meanp<-total/nsamp
        
        return(meanp)
        
        
}