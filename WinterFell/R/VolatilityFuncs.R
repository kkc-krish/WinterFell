## High low as % of previous day close
library(quantmod )

HighLowVol <- function(ticker = 'AAPL', n =50)
{

  prdData = getSymbols(ticker, auto.assign = F ,from = '2015-01-01')
  names(prdData) = c('Open', 'High','Low','Close','Volume','Adjusted')
  hl_diff = 100* ((prdData$High - prdData$Close) / lag(prdData$Adjusted))
  rollingMean =  rollmean(hl_diff,k = n)
  plot(rollingMean,main = paste0('High -Low as % of previous close for ',ticker))

}

par(mfrow = c(2,2))
HighLowVol('TSLA')
HighLowVol('AAPL')
HighLowVol('AMZN')
HighLowVol('NFLX')

t1 = HighLowVol('TSLA')
t2 = HighLowVol('AAPL')
t3 = HighLowVol('AMZN')
t4 = HighLowVol('NFLX')

allTS = merge.xts(t1,t2,t3,t4)
names(allTS) = c('TSLA','AAPL','AMZN','NFLX')
dygraphs::dygraph(allTS)

cor(allTS, use = 'pairwise.complete.obs')
TTR::CMF
