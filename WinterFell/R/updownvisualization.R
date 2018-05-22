library(quantmod)
library(ggplot2)
library(plotly)

## last 15 days
startDate  = Sys.Date() - 30

stock = getSymbols('TSLA', from  = startDate,auto.assign = F)
dr = dailyReturn(stock[,6])
updwn = as.data.frame(ifelse(dr > 0 , 1, -1))
updwn$date = rownames(updwn)

p1 = ggplot(updwn, aes(x = as.Date(date),y = daily.returns, fill = factor(daily.returns))) +
         geom_bar(stat = 'identity') + theme(legend.position='none') +
  xlab('Last 30 days') + ylab('Up Down Counter') + ylim(-2,2)


ggplotly(p1)
