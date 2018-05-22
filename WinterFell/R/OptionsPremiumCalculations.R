# symbol = 'WMT'
# years = '2018'
# optionData <- quantmod::getOptionChain(Symbols = symbol,years)
# DT = data.table(reshape2::melt(optionData, id = c('Strike' ,'Last' ,'Chg', 'Bid','Ask','Vol','OI')))
# DT$L1 = as.Date(gsub(pattern = "\\.", replacement = " ", x = DT$L1),format = "%b %d %Y")
# DT = DT[L2 =='calls']
# # get most recent closing price
# stock = getSymbols('WMT', auto.assign =F)
# mostRecentclose = as.numeric(tail(stock[,paste0(symbol,".Adjusted"),])[1])
#
# DT[,IntrinsicValue := (mostRecentclose - Strike) ]
# DT[,TimePremium := ifelse(IntrinsicValue >= 0, (Last - IntrinsicValue), Last)]
#
# ggplot(DT , aes(x = Strike, y = TimePremium)) + geom_line() +
#   facet_wrap(~ Strike, dir ='h', nrow = 3)
#
# which(table(DT$Strike) > 15)
