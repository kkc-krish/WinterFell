# library(tidyquant)
# library(tidyverse)
# library(reshape2)
#
# symbols = c('GS','AAPL','NFLX','AMZN','TSLA','MS',
#             'FB', 'GOOGL','BA','BABA','MU','NVDA')
# startDate =as.Date('2015-01-01')
# prices = lapply(symbols, function(x) tidyquant::tq_get(x = x,
#                                                        from = startDate ))
# dailychange = lapply(prices, function(x){ as.xts(100*(x$high - x$low)/x$close,
#                                                  order.by = as.Date(x$date))})
#
# times = seq.Date(from = as.Date('2015-01-01'), to= Sys.Date(), by = 'day')
# names(dailychange) = symbols
#
# allData = melt(dailychange )
# allData = cbind.data.frame(allData, date = prices[[1]]$date)
#
# ggplot(allData, aes(x = date, y = value, color = L1)) +
#   geom_line() +
#   facet_wrap(~ L1, scales = 'fixed')
