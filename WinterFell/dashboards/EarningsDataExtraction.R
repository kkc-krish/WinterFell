#' FetchEarningsReleaseList
#' @description fetch a table of earnings calendar on that particular date
#' @param date Input the date for the calendar
#' @return DF Data frame of copmany names, expected EPS and timings of earnings release
#' @export
FetchEarningsReleaseList <- function(date = Sys.Date())
{
  myDate = as.character(format(as.Date(date),"%Y-%m-%d"))
  baseURL = 'https://finance.yahoo.com/calendar/earnings?day='
  myURL <- paste0(baseURL,myDate)
  allData = GetHTMLTables(myURL = myURL)
  if(length(allData)  < 2)
  {
    print("No Companies to report")
    return(data.frame(Symbol = NA, Company = NA, Sector = NA,
                      Mcap = NA, EPS_Est = NA, EPS_Reported = NA,
                      EPS_Surp = NA, EarningsDate = as.character(date)))
  } else
  {
    earningsCalendar = allData[[2]] %>% select (-1)
    earningsCalendar$Date = as.character(date)
    names(earningsCalendar) <- c('Symbol','Company', 'Time','EPS_Est','EPS_Reported','EPS_Surp','EarningsDate')
    allCompanies = FetchAllListings()
    finalList = merge(earningsCalendar, allCompanies, by = 'Symbol')
    finalList = finalList %>%
      select(Symbol, Company = Company.x, Sector, MCap,EPS_Est, EPS_Reported, EPS_Surp, EarningsDate)
    finalList  = finalList %>% arrange(Sector)
    finalList$MCap = McaptoMillions(mcap = finalList$MCap)
    return(finalList)
  }


}


#' GlobalIndicesPerformance
#' @description get the world indices performance for the most recent trading day
#' @param myURL URL for reading the data from
#' @return returns a ggplot and data frame of world indices with most recent 1 day performence.
#' @export
GlobalIndicesPerformance <- function(myURL= NULL)
{

  # Another source to check http://www.wsj.com/mdc/public/page/2_3022-intlstkidx.html

  allData <- GetHTMLTables(myURL = 'https://finance.google.com/finance')
  indexWM = which(sapply(allData, function(x)('Shanghai' %in% as.character(x[,1]))))
  marketData <- allData[[indexWM]]
  names(marketData) <- c('Index','Level','Change')
  marketData <- marketData[complete.cases(marketData),]

  ## do some data clearning
  marketData$Index <- as.character(marketData$Index)
  marketData$Level <- gsub(pattern = ",",replacement = "",x = marketData$Level)
  marketData$Level <- as.numeric(as.character(marketData$Level))
  marketData$Change <- as.character(marketData$Change)

  ## Try to add region column as well for breakdown

  ##Clean up  % Change colum
  change <- marketData$Change
  marketData$Change = NULL
  change <- gsub("+",replacement = "",x = change)
  change <- gsub(",",replacement = "",x = change)
  DiffChange <- sub(pattern = '.*\\(',replacement = "", x = change)
  DiffChange <- as.numeric(sub(pattern = '%.*',replacement = "", x = DiffChange))
  change <- sub(pattern = '\\(.*',replacement = "", x = change)
  change <- as.numeric(change)

  marketData <- cbind.data.frame(marketData, Change = change, DiffChange = DiffChange)
  colorScale <- factor(ifelse(marketData$DiffChange >0, 1,0))

  myPlot <- ggplot(marketData, aes(x = Index, y = DiffChange, fill = colorScale)) +
    geom_bar(stat = 'identity') + coord_flip() +guides(fill=FALSE) +
    ggtitle(paste0( 'Global Market Indicies : ', Sys.Date())) +
    scale_fill_manual("legend",values = c("1" = " dark green", "0" = "red")) + theme_bw() +
    theme(plot.title = element_text(hjust = 0.5))

  print(myPlot)

  return(marketData)
}

#' GetHTMLTables
#' @description helper function to read HTML tables from a website and retrieve a list of all html tables on that page.
#' @import XML
#' @import RCurl,rlist
#' @export
GetHTMLTables <- function(myURL = NULL)
{
  theurl <- getURL(myURL,.opts = list(ssl.verifypeer = FALSE) )
  tables <- readHTMLTable(theurl)
  tables <- list.clean(tables, fun = is.null, recursive = FALSE)
  return(tables)
}

## Take universe as SP500 + R3000
FetchAllListings <- function()
{
  nyse = tq_exchange('NYSE')
  amex = tq_exchange('AMEX')
  nasdaq = tq_exchange('NASDAQ')
  allCompanies = rbind(nyse, amex, nasdaq)
  names(allCompanies) = c('Symbol','Company','LastClose','MCap','IPOYear','Sector','Industry')
  return(allCompanies)
}
