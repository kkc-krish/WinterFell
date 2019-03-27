#
#
# mktSymbols = c('SPY', 'XLK', "XLB","XLY","XLP","XLRE","XLI", "XLV","XLU","XLE","XLF")
# sectorETFs = c('SP500',"Technology","Materials", "Consumer Discretionary",
#                "Consumer Staples", "Real Estate","Industrial", "Health Care" ,"Utilities" ,"Energy" ,"Financials")
# monthsN = c('Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec')
#
# sectorRetData = xts()
#
# for(s in mktSymbols) {
#   prices = getSymbols(Symbols = s,auto.assign = F)[,6]
#   monthlyRet = monthlyReturn(prices)*100
#   sectorRetData = cbind.xts(sectorRetData,monthlyRet)
#
# }
#
# sectorRetData = as.data.frame(sectorRetData)
# names(sectorRetData) = sectorETFs
# sectorRetData = sectorRetData %>% mutate(months = month(as.Date(rownames(sectorRetData))))
# temp = data.table::melt(sectorRetData, id.vars ='months')
# temp = temp %>% group_by(months, variable) %>% summarise(AvgMonthlyRet = mean(value, na.rm = T))
# temp$months = sapply(temp$months, function(x) switch(x,
#                      '1' ='January',
#                     '2' ='February',
#                      '3' ="March",
#                      '4' ="April",
#                      '5' ="May",
#                      '6' ="June",
#                      '7' ="July",
#                      '8' ='August',
#                      '9' ='September',
#                      '10'='October',
#                      '11'='November',
#                      '12'='December'
#                      ))
# temp$months = factor(temp$months, levels = month.name)
# retType = ifelse(temp$AvgMonthlyRet > 0 ,"Positive", "Negative")
# temp = cbind.data.frame(temp, retType)
