#Libraries
library("redux")

#Local Connection
r <- redux::hiredis(redux::redis_config(host = "127.0.0.1",port = "6379"))

#Connection to steaming server
con <- socketConnection(host="46.101.203.215", port = 1337, blocking=TRUE,server=FALSE, open="r+")

#Create key-values to Redis Server
while(TRUE){
  server_resp <- readLines(con, 1)
  print(server_resp)
  
  #Split the input string
  stockID<- gsub(",.*", "", server_resp) #We used regular expressions to take the stock_id e.g "FB"
  stockVALUES<- gsub("^[^,]*[$,]", "", server_resp) #We used regular expressions to take the rest values, price, sell and buy volume
  
  # We store the data in Redis server. Finally, we will have 11 lists one for each stock_id
  r$RPUSH(stockID,stockVALUES)
  
  ####################################
  #We add this extra script for settting the task_8
  ####################################
  if (stockID=="GOOG")
  {
    #time
    t<-Sys.time()
    
    #Convert the time to seconds
    time.epoch <- as.vector(unclass(t))
    time.epoch<-as.character(time.epoch)
    
    #List range
    lis<-r$LRANGE("GOOG",0,-1) 
    n<-length(lis)
    n<-as.character(n)
    
    #Create a set for task_8
    r$ZADD("GOOG_TIME_SET",time.epoch , n)
  }
  
  }
