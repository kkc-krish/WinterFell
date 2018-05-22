#' GetOpenInterestData
#' @export
#'
GetOpenInterestData <- function(symbol = 'WMT', years = '2017/2018')
{
  library(dplyr)
  optionData <- quantmod::getOptionChain(Symbols = symbol,years)

  DT = data.table(reshape2::melt(optionData,
                                 id = c('Strike' ,'Last' ,'Chg', 'Bid','Ask','Vol','OI')))

  DT$L1 = as.Date(gsub(pattern = "\\.", replacement = " ", x = DT$L1),format = "%b %d %Y")
  optionsummary = DT[,.(TotalOI = sum(OI, na.rm = T),
                        TotalVol = sum(Vol,na.rm = T)), by = .(L1,L2)]
  data.table::setnames(optionsummary, 1:2,c("ExpiryDate", "OptionType"))

  optionsSummary = melt.data.table(optionsummary, id.vars = c('ExpiryDate','OptionType'))

  myPlot = ggplot(optionsSummary, aes(x = ExpiryDate, y = value, fill = OptionType)) +
    geom_bar(stat = 'identity', position = 'dodge') +
    xlab('Expiration') +
    scale_fill_manual("legend", values = c("calls" = "dark green", "puts" = "red")) +
    theme(axis.text.x = element_text(angle = 45, hjust = 1),plot.title = element_text(hjust = 0.5)) +
    ggtitle(label = paste0('Option Summary : ', symbol)) +
    facet_wrap("variable", scales = 'free', dir = 'v')

  return(list(summary = optionsummary, plot = myPlot))

}
