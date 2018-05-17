#Libraries
library("redux")

#Local Connection
r <- redux::hiredis(redux::redis_config(host = "127.0.0.1", port = "6379"))

table<-c("GOOG","CSCO","AAPL","GRPN","FB","MSFT","INTC","NVDA","QCOM","AMZN","TSLA")

#Create a vector with 11 zeros, I will use this vector as pointer in each ID in order to optimize the memory
n_table<-rep(1,11)

#Initialization the min,max,avg for each stock id
min_table<-rep(NA,11)
max_table<-rep(NA,11)
avg_table<-rep(NA,11)


#Read from the Redis-Server
while(TRUE)
{
  for (i in 1:11)
  { n<-length(r$LRANGE(table[i],0,-1))
    if (n_table[i]+1<=n)
    {
      lis<-r$LRANGE(table[i],n_table[i],n_table[i]+1)
      n_table[i]<-n_table[i]+1 # Update the pointer
      prices <- gsub(",.*", "", lis) #Take the price by using regular expression
      
      #This if statement is to divide the first time we calculate the min, max, avg from the others
      if (is.na(avg_table[i]) || is.na(min_table[i]) || is.na(max_table[i]) )
      { print(table[i])
        print(min_table[i]<-min(as.numeric(prices),na.rm=TRUE))
        print(max_table[i]<-max(as.numeric(prices),na.rm=TRUE))
        print(avg_table[i]<-mean(as.numeric(prices),na.rm=TRUE))
      }
      else
      { print(table[i])
        print(min_table[i]<-min(as.numeric(prices),min_table[i],na.rm=TRUE))
        print(max_table[i]<-max(as.numeric(prices),max_table[i],na.rm=TRUE))
        print(avg_table[i]<-mean(as.numeric(prices),avg_table[i],na.rm=TRUE))
      }  
    } 
  }
  
}









