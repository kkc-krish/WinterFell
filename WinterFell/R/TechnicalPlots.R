library(quantmod)
library(TTR)
library(dygraphs)

FetchRSIPlot <- function(symbol = NULL, timeexp = '2018::')
{
  price = getSymbols(symbol,auto.assign = F)[,6][timeexp]
  rsi = RSI(price)
  dygraphs::dygraph(rsi) %>% dyRangeSelector()
}
