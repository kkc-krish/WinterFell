## function to get the API Key

QuandlAPIKey <- function()
{
  Quandl::Quandl.api_key(api_key = 'PUVWwAAQ_hPKYPpJ1HzF')
}


## Convert the market cap colum to appropriate values.
McaptoMillions <- function(mcap = NULL)
{
  numValues = parse_number(mcap)
  numValues = ifelse(is.na(numValues), NA,
                           ifelse(grepl(pattern = "B", mcap),
                                  numValues*1000,
                                  numValues))
  return(numValues)
}

#' GetSP500Tickers
#' @export
GetSP500Tickers <- function()
{
  library(rvest)
  url <- "https://en.wikipedia.org/wiki/List_of_S%26P_500_companies"
  SP500 <- url %>%
    html() %>%
    html_nodes(xpath='//*[@id="mw-content-text"]/div/table[1]') %>%
    html_table()
  SP500 <- SP500[[1]]
  Tix <- SP500$`Ticker symbol`
  return(Tix)
}


## ChartSerie with Plotly
ChartSeriesPlotly <- function(Date = index(tt), series1 = tt[,5], series2 = tt[,6])
{
  ay <- list(
    tickfont = list(color = "red"),
    overlaying = "y",
    side = "right",
    title = "Price"
  )
  ds <- data.frame(Date, series1, series2)
  names(ds) <- c('Date','Volume','Close')
  p<- plot_ly(ds, x = ~Date ) %>%
    add_bars(y = ~ Volume, name = 'Volume') %>%
    add_lines(y = ~ Close, name = 'AdjClose', yaxis = "y2") %>%
    layout(
      title = "Price Chart",
      yaxis2 = ay,
      xaxis = list(
        rangeselector = list(
          buttons = list(
            list(
              count = 3,
              label = "3 mo",
              step = "month",
              stepmode = "backward"),
            list(
              count = 6,
              label = "6 mo",
              step = "month",
              stepmode = "backward"),
            list(
              count = 1,
              label = "1 yr",
              step = "year",
              stepmode = "backward"),
            list(
              count = 1,
              label = "YTD",
              step = "year",
              stepmode = "todate"),
            list(step = "all"))),

        rangeslider = list(type = "date")),

      yaxis = list(title = "Volume"))

  p
}

