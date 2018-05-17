 #Libraries
library("redux")

#Local Connection
r <- redux::hiredis(redux::redis_config(host = "127.0.0.1", port = "6379"))


table<-c("GOOG","CSCO","AAPL","GRPN","FB","MSFT","INTC","NVDA","QCOM","AMZN","TSLA")

while(TRUE)
{ #We have 11 stock_ids so we have to add it in a loop
  for (i in 1:11)
  { #Calculate the length of the list
    n1<-length(r$LRANGE(table[i],0,-1))
    
    #With this if statement we can check if we have less than 30 elements,in the contrary if we have more than 30 we use 'else if'
    if (n1>=30)
    { print(table[i])
      lis<-r$LRANGE(table[i],n1-30,-1) #We read the last 30 elements (sliding Window)
      prices <- gsub(",.*", "", lis) # We used regular expression to take the price
      print(mean(as.numeric(prices)))
    }
    else if (n1>0 && n1<30) # In this case we have less than 30 elements so we calculate the avg of these elements
    { print(table[i])
      lis<-r$LRANGE(table[i],0,-1)
      prices <- gsub(",.*", "", lis) #We read the last 30 elements (sliding Window)
      print(mean(as.numeric(prices)))#We used regular expression to take the price
    }
   
  }
  

}



