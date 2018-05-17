#Libraries
library("redux")

#Local Connection
r <- redux::hiredis(redux::redis_config(host = "127.0.0.1", port = "6379"))


table<-c("GOOG","CSCO","AAPL","GRPN","FB","MSFT","INTC","NVDA","QCOM","AMZN","TSLA")

while(TRUE)
{
  for (i in 1:11)
  {
    lis<-r$LRANGE(table[i],0,-1)  #Take all the list for each stock_id, (Note: for optimization we could use a technique as we did in Task 4)
    prices <- gsub(",.*", "", lis) #We take the price value from the stream by using regular expression
    avg<-mean(as.numeric(prices)) # Calculate the average price for the current day
    price_cl<-as.numeric(r$GET(paste(table[i],":price_close", sep = ""))) # Calculate the average price for the day before
    
    #Stock_id name
    print(table[i])
    
    #We print the final result (also we round the result)
    print(paste(as.character(round((avg-price_cl)/avg*100),1),"%"))
  }
 
}

