#' FetchStockInfo
#' @description get the stock info chart a time series along with the volume
#' @param symbol ticker of the stock
#' @return OHLC object of the stock
#' @export
FetchStockInfo <- function(symbol = 'CHK', fromDate = '2015-01-01')
{

  stockTS = getSymbols(Symbols = symbol,auto.assign = F,from = fromDate)
  chartSeries(stockTS,theme = 'white',name = symbol)
  dygraphs::dygraph(stockTS)
  return(stockTS)
}

#' GetPeriodReturns
#' @description Get period returns based on the periodicity provided
#' @param symbol ticker of the stock
#' @param period periodicity of returns needed. could be daily, weekly, monthly, quarterly, yearly.
#' @return OHLC object of the stock with returns
#' @export
GetPeriodReturns  <- function(stock , period = 'daily')
{
  returnFunc = switch(period,
                      'daily' = dailyReturn,
                      'week'= weeklyReturn,
                      'month' = monthlyReturn,
                      'quarter' = quarterlyReturn,
                      'year' = yearlyReturn,
                      stop('Incorrect period'))

  returnSeries = do.call(what = returnFunc,args = list(stock ))
  return(returnSeries)
}


#' UpDownVolumeRatio
#' @description Ratio of volume traded in updays over downdays
#' @param symbol ticker of the stock
#' @param filter expression to subset the time series. as used by quantmod.
#' @return ratio of volume to understand its up or down market
#' @export

UpDownVolumeRatio <- function(symbol = 'AAPL', filter = NULL)
{
  stockTS = getSymbols(Symbols = symbol,auto.assign = F)
  returns = GetPeriodReturns(stockTS, period = 'daily')
  temp1  = as.data.frame(stockTS)
  temp2 = as.data.frame(returns)

  merge(temp1, temp2,by = 0) %>% select(daily.returns)
}

# Function to plot a wordcloud for most talked about companies on social media.
# Sources include Twitter.


