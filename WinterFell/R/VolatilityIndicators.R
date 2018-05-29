#' GetATR
#' @description Average True Range of the stock (ATR indicator)
#' @param  ohlc ohlc data for a stock
#' @param n  periods for calculating moving average for ATR
#' @param type  method to calculate MA (either 'SMA' or 'EMA')
#' @param  periods number of most recent data points to be fetched
#' @return series of ATR
#' @export
GetATR <- function(ohlc = NULL, n = 14, type ='EMA', periods = nrow(ohlc))
{
  names(ohlc) = c('Open' ,"High","Low","Close","Volume","Adjusted")
  ohlc <- round(ohlc[complete.cases(ohlc),],2)

  p1 = ohlc$High - ohlc$Low
  p2 = abs(ohlc$High - lag(ohlc$Close, n = 1))
  p3 = abs(ohlc$Close - lag(ohlc$Close, n= 1))

  atr = apply(data.frame(p1,p2,p3), max, MARGIN = 1)
  avg = tail(do.call(type, list(atr,n)), periods)
  return(avg)
}
