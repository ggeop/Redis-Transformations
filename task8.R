#Libraries
library("redux")

#Local Connection
r <- redux::hiredis(redux::redis_config(host = "127.0.0.1", port = "6379"))


while(TRUE){
  
  #Realtime count
  Real_time<-Sys.time()
  
  n1<- as.vector(unclass(Real_time))   #n1 assigned as the time now
  n2<-n1-20   #n2 assigned as the time minus 20 seconds
  
  #Convert them to characters
  n1<-as.character(n1)
  n2<-as.character(n2)
  
  
  #We calculate the range of the elements for the last 20 seconds
  n<-r$ZREMRANGEBYSCORE ("GOOG_TIME_SET",n2,n1)
  
  #Finally we print the average price of GOOG's stock
  lis<-r$LRANGE("GOOG",n,-1) 
  prices <- gsub(",.*", "", lis)
  print(avg<-mean(as.numeric(prices)))
}





