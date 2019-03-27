library(quantmod)
library(plotly)

aapl = getSymbols('AMD',auto.assign = F, from = '2015-01-01')
adjClost = aapl[,6]

mr = monthlyReturn(adjClost)
head(mr)
myMonth = months(index(mr), abbreviate = T)
p1 = ggplot() +
  geom_boxplot(mapping = aes(x = myMonth, y = mr$monthly.returns), fill = 'light blue')  +
  xlab('Month') + ylab('Monthly Returns') + theme_bw()

p1
ggplotly(p1)
