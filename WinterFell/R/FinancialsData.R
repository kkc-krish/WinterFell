library(tidyquant)
library(data.table)


symbol = 'AAPL'


financials = tq_get(x = symbol , get = 'financials')

keyratios = tq_get(x = symbol , get = 'key.ratios')
allRatios = rbindlist(keyratios$data)

dividends = tq_get(x = symbol, get ='dividends')
