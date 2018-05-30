#' GetReturnSeries
#' @description fetch a table of earnings calendar on that particular date
#' @param  series time series of the stock
#' @param dailyReturn  flag to calculate daily return
#' @param weeklyReturn flag to calcualte weekly return
#' @param monthlyReturn flag to calculate monthly return
#' @param periods  number of most recent periods to return
#' @return list of all return series that are calculated
#' @export
GetReturnSeries <- function(series = NULL,dailyReturn = T,
                            weeklyReturn = T, monthlyReturn = T, periods = length(series))
{
  dailyRet = NULL
  weeklyRet = NULL
  monthRet = NULL

  if(dailyReturn) dailyRet  = as.numeric(tail(round(dailyReturn(series)*100,2), periods))
  if(weeklyReturn) weeklyRet = as.numeric(tail(round(weeklyReturn(series)*100,2),periods))
  if(monthlyReturn) monthRet  = as.numeric(tail(round(monthlyReturn(series)*100,2),periods))

  return(list(dailyRet= dailyRet, weeklyRet=weeklyRet, monthRet = monthRet))

}


#' GetMovingAverages
#' @description fetch a table of earnings calendar on that particular date
#' @param  series time series of the stock
#' @param n  flag to calculate daily return
#' @param periods flag to calcualte weekly return
#' @return DF Data frame of copmany names, expected EPS and timings of earnings release
#' @export
GetMovingAverages <- function(price = NULL,volume = NULL, n= 50, periods = length(price), type = 'SMA')
{
  if (type %in% c('VWMA', 'VWAP'))
  {
    avg = do.call(type, args = list(price = price, volume = volume, n = n))

  } else {
    avg = do.call(type, args = list(x = price, n = n))
  }

  avg = round(tail(avg, periods),2)
  return(as.numeric(avg))
}
