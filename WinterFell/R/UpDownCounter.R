library(quantmod)
library(xts)
library(data.table)
df = getSymbols('^DJI', auto.assign = F)[,6]
dfR = dailyReturn(df)
dailyR = ifelse(dfR >0 , "Up", "Down")

totalPosCounter= vector()
totalNegCounter = vector()

## Calculate the consecutive up and down days and spit out a vector for the same.
## first for Positive counter and other for negative counter
UpDown <- function(retSeries = NULL)
{
  retSeries = as.vector(retSeries)
  retSeries = ifelse(retSeries >0 , "Up", "Down")
  counterLength = length(retSeries) - 1
  print(counterLength)
  poscounter = 0
  negcounter = 0

  for(i in 1: counterLength)
  {

    if(retSeries[i] == 'Up')
    {
      poscounter = poscounter + 1
      if(retSeries[i+ 1] == 'Down')
      {
        totalPosCounter = append(totalPosCounter, poscounter)
        poscounter = 0
      }
    } else {
      negcounter = negcounter + 1
      if(retSeries[i+ 1] == 'Up')
      {
        totalNegCounter = append(totalNegCounter, negcounter)
        negcounter = 0
      }
    }

  }
  return(list(UpCounter = totalPosCounter, DownCounter = totalNegCounter))
}

