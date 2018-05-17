#Libraries
library("redux")

#Local Connection
r <- redux::hiredis(redux::redis_config(host = "127.0.0.1", port = "6379"))


table<-c("GOOG","CSCO","AAPL","GRPN","FB","MSFT","INTC","NVDA","QCOM","AMZN","TSLA")

while(TRUE)
{
  for (i in 1:11)
  { n1<-length(r$LRANGE(table[i],0,-1))
    if (n1>=30) #We check if we have more than 30 elements
    {
      lis<-r$LRANGE(table[i],n1-30,-1)
      
      #Ratio_1 is for the current day
      stream_sell<-mean(as.numeric(gsub(',.*', '',gsub('^[^,]*[$,]', '',lis))))
      stream_buy<-mean(as.numeric(gsub('.*,', '', lis)))
      ratio_1<-stream_buy/stream_sell
      
      
      #Ratio_2 is for the last day
      volume_buy<-as.numeric(r$GET(paste(table[i],":","volume_buy", sep = "")))
      volume_sell<-as.numeric(r$GET(paste(table[i],":","volume_sell", sep = "")))
      ratio_2<-volume_buy/volume_sell
      
      #Avg in sentiment
      avg<-as.numeric(r$HGET(paste("Stock_id:",table[i], sep = ""),"avg_sentiment"))
      
      #Final print of the ids
      if (ratio_1>ratio_2 && avg > 2.5) 
      {print(table[i])}
    }
    else if (n1<30 && n1>0) #If we don't have more than 30 elements
    {
      lis<-r$LRANGE(table[i],0,-1)
      
      #Ration_1 is for the current day
      stream_sell<-mean(as.numeric(gsub(',.*', '',gsub('^[^,]*[$,]', '',lis))))
      stream_buy<-mean(as.numeric(gsub('.*,', '', lis)))
      ratio_1<-stream_buy/stream_sell
      
      
      #Ratio_2 is for the last day
      volume_buy<-as.numeric(r$GET(paste(table[i],":","volume_buy", sep = "")))
      volume_sell<-as.numeric(r$GET(paste(table[i],":","volume_sell", sep = "")))
      ratio_2<-volume_buy/volume_sell
      
      #Avg in sentiment
      avg<-as.numeric(r$HGET(paste("Stock_id:",table[i], sep = ""),"avg_sentiment"))
      
      #Final print of the ids
      if (ratio_1>ratio_2 && avg > 2.5) 
      {print(table[i])}
      
    }
  }
  
}


