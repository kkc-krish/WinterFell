library(ggplot2)
library(data.table)
dates = seq(Sys.Date(),by = 'day',to = as.Date('2018-05-31'))

weeklyPerf = lapply(dates, FetchEarningsReleaseList)
weeklyData = rbindlist(weeklyPerf)

head(weeklyData)

head(weeklyData)
weeklyData$CapBreakdown =ifelse(weeklyData$MCap >=10000 ,'LargeCap',
                                ifelse(weeklyData$MCap >=2000, 'MidCap',
                                       'SmallCap'))

## Parsing numbers
weeklyData$EPS_Surp = parse_number(weeklyData$EPS_Surp)

## Sector Wise Earnings Surprise
sectorSurp = weeklyData %>% group_by(Sector) %>% summarise(AvgSurp = weighted.mean(x = EPS_Surp,w = Mcap, na.rm = T))
sectorSurp = sectorSurp[complete.cases(sectorSurp),]
mcapSurp = weeklyData %>% group_by(CapBreakdown) %>% summarise(AvgSurp = weighted.mean(EPS_Surp,Mcap,  na.rm = T))
mcapSurp = mcapSurp[complete.cases(mcapSurp),]
## Plot
Esurp = ifelse(sectorSurp$AvgSurp > 0 , "Positive", "Negative")
ggplot(sectorSurp, aes(reorder(Sector, AvgSurp), AvgSurp,fill = Esurp )) +
  geom_bar(stat ='identity') + coord_flip() +
  scale_fill_manual(values = c('Positive' ='Dark Green', 'Negative' ='Red' ))

CapSurp  = ifelse(mcapSurp$AvgSurp > 0 , "Green", "Red")
ggplot(mcapSurp, aes(x = CapBreakdown, y = AvgSurp, fill = CapSurp)) + geom_bar(stat ='identity') +
   scale_fill_manual(values = c('Green' ='Dark Green', 'Red' ='Red' ))
