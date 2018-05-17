#Library
library("redux")

#Local Connection
r <- redux::hiredis(redux::redis_config(host = "127.0.0.1", port = "6379"))

#Import aggregated_stock_data
aggregated_stock_data <- read.csv("~/Desktop/Redis/aggregated_stock_data.csv")

#Create the value pairs (Conventions)
for (i in 1:nrow(aggregated_stock_data))
  { 
  r$SET(paste(aggregated_stock_data[i,1],":","price_open", sep = ""),aggregated_stock_data[i,2])
  r$SET(paste(aggregated_stock_data[i,1],":","price_close", sep = ""),aggregated_stock_data[i,3])
  r$SET(paste(aggregated_stock_data[i,1],":","volume_buy", sep = ""),aggregated_stock_data[i,4])
  r$SET(paste(aggregated_stock_data[i,1],":","volume_sell", sep = ""),aggregated_stock_data[i,5])
  }

