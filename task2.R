#Libraries
library("redux")
library("rjson")
library("jsonlite")

#Local Connection
r <- redux::hiredis(redux::redis_config(host = "127.0.0.1",port = "6379"))

#Import Json file
#setwd("~/Desktop/Redis"), we set the working directory
json_data <- fromJSON("sentiment.json") #Import the json file

#Load data to Redis Server
for (i in 1:length(json_data))
{
  #We calculate the mean for each sentiment
  avg<-mean(json_data[[i]][2][,1])
  
  #We transform it to character
  avg<-as.character(avg)
  
  #We take the name of each stock id
  stock<-names(json_data[i])
  
  #We store it to Redis Server using Hushes
  r$HSET(paste("Stock_id:",stock, sep = ""),"avg_sentiment",avg)
}

       