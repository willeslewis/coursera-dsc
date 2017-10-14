corr<-function(directory,threshold=0){
        #This function calculates the correlation between sulfate and nitrate
        #using all monitor files which have complete cases > threshold
        
        #directory is the location of the spectral data (input as string)
        #threshold is the minimum number of complete cases required to include
        #a given monitor's data in the correlation calculation
        
        #get id's we care about. (This seems inefficient to me...
        #we load a bunch of data frames do calulations to find which ones we care
        #about the reload the ones we care about.)
        compdf<-complete("specdata",1:332)
        #keep only what is consistent with threshold value
        newdf<-compdf[compdf$nobs>threshold,]
        #get id vector
        ids<-newdf$id
        
        
        #initialize correlation vector
        corvec<-vector(mode="numeric",length=length(ids))

        if(length(ids)>0){
                for(i in 1:length(ids)){
                        
                        #id's must be 3 digits so preappend zeros if id is less than 100
                        
                        if(ids[i]<10){
                                idmod<-paste("00",ids[i],sep="")
                        }else if(ids[i]<100){
                                idmod<-paste("0",ids[i],sep="")
                        }else{
                                idmod<-ids[i]
                        }
                        
                        data<-read.csv(paste(directory,"/",idmod,".csv",sep=""))  
                        
                        #update the correlation vector
                        corvec[i]<-cor(as.vector(data$sulfate),as.vector(data$nitrate),"pairwise.complete.obs")
                        
                }
        }
        
        return(corvec)
}