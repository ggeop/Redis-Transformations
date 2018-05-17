# Redis-Basic-Transformations (University Assignment)
We are going to use Redis to store a financial data stream and answer stream queries. We will use Redux API in order to connect to Redis Server.

## Senario
You are a data analyst at a financial firm and you have access to a data stream of stock prices and buy/sell volumes of several popular companies’ stocks. You also have access to previous day’s aggregated information about these stocks. You are asked to create a number of programs for the tasks listed in the “TASKS” section.

## STREAM INPUT

### GENERAL NOTES
Tuples returned from the server are in the form of:
“STOCK_ID, STOCK_PRICE, SELL_VOLUME, BUY_VOLUME”

### Field Description
-	STOCK_ID: The ID of the stock. Eg. GOOG stands for Google.

-	STOCK_PRICE: The current price of the stock.

-	SELL_VOLUME: The number of stocks that had been sold by the time this tuple was generated. This is constantly increasing as time goes by and is reset on each new day.

-	BUY_VOLUME: The number of stocks that had been bought by the time this tuple was generated. This is constantly increasing as time goes by and is reset on each new day.

### Tasks

**Task 1:**
Write a program that reads the data stored in “aggregated_stock_data.csv” and stores values per stock id to Redis in an appropriate format. You should store values in a way to support the programs in Tasks 6-7.

**Task 2:**
Write a program that reads the data stored in “sentiment.json” and stores values per stock id to Redis in an appropriate format. You should store values in a way to support the programs in Task 7.

**Task 3:**
Write a program that reads the stream and stores values per stock id to Redis in an appropriate format. You should store values in a way to support the programs in Tasks 4-8.

**Task 4:**
Write a program that reads in from Redis and prints out for each stock id the average, minimum and maximum price since the starting point of storing the data stream. Write your program in a way that minimizes memory usage.

**Task 5:**
Write a program that reads in from Redis and prints out for each stock id the average price of the last 30 stock’s reported prices (a sliding window of size 30). 

**Task 6:**
Write a program that reads in from Redis and prints out for each stock id the difference (as a percentage) of the average price of each stock since the starting point of storing the data stream, compared to the closing price of this stock (available at the .csv file). 

**Task 7:**
Write a program that reads in from Redis and prints out the stock ids that:
-	Have an average buy/sell ratio of the last 30 reported prices that is bigger than last day’s buy/sell ratio (available at the .csv file).
-	And at the same time an average sentiment value that is bigger than 2.5 (available at the .json file).

**Task 8:**
Write a program that reads in from Redis and prints out the average price of the GOOG’s stock for the last 20 seconds (a sliding window of 20 seconds).
