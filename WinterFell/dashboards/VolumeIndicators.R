#' GetMovingAverages
#' @description fetch a table of earnings calendar on that particular date
#' @param  retSeries dailyreturn series of the stock
#' @param  volume volume series corresponding to retSeries
#' @param periods  periods over which ratio should be calculated. defaulted to 30
#' @return updown ratio that is calculated
#' @export
UpDownVolRatio <- function(retSeries = NULL, volume = NULL, periods = 30)
{

  upDwn = ifelse(retSeries > 0 , 1, -1)
  temp = tail(cbind.data.frame(upDwn = upDwn, volume =volume), periods)
  names(temp) = c('upDwn','volume')
  temp = temp %>% group_by(upDwn) %>%
    summarise(TotalVol = sum(volume, na.rm = T)) %>% arrange(TotalVol)
  upDownRatio = temp$TotalVol[1] / temp$TotalVol[2]
  return(upDownRatio)
}

#' GetVolRatios
#' @description calculate the avg volume ratio for the two periods specificed
#' @param  volume volume series corresponding to retSeries
#' @param n1  periods in numerator
#' @param n2  periods prior to n1 in denominator
#' @return volume ratio to be calculated
#' @export
GetVolRatios <- function(volume = NULL, n1 = 10, n2 = 30)
{
  r1  = mean(tail(volume, n1), na.rm = T)
  r2  =  mean(tail(volume, n1 + n2)[- c(1:n1)], na.rm = T)
  ratio = r1/r2
  return(ratio)
}


