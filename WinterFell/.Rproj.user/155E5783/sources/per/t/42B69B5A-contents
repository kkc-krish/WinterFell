allData = GetHTMLTables(myURL = 'https://finance.yahoo.com/quote/AAPL/analysis?p=AAPL')
allData[[1]] = NULL
allData
names(allData) <- c('EarningsEstimate','RevenueEstimate','EarningsHistory','EPSTrend','EPSRevisions','GrowthEstimates')
rbindlist(allData, idcol = T)
