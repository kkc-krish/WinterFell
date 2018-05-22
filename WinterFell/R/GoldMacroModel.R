#' GoldvsAssetComparison
#' @description function to compare Gold with other Macro Indicators
#' @param  item vix, treasury, dollar
#' @startDate startdate of the analysis
#' @export
GoldvsAssetComparison <- function(item = NULL, startDate = NULL)
{
  # set the API key
  QuandlAPIKey()

  ## Get the macro data

  ## To understand the impact of gold, 5 factors are taken into account.
  ## Volatility , Interest rates, Inflation, Currency Fluctuation, Supply & Demand
  gold       <- as.xts(data.frame(Quandl(code = 'LBMA/GOLD',type = 'xts')[,4]))

  quandlCode <- switch( item ,
                  'vix' = "CBOE/VIX",
                  'treasurey' ="USTREASURY/LONGTERMRATES",
                  'dollar' = "FRED/DTWEXM",
                  stop("Add the code of the item for Quandl"))

  itemData <- as.xts(data.frame( Quandl(code = quandlCode,type = 'xts')[,1]))

  ## volatility of gld futures
  gldVol <- Quandl(code = 'CBOE/GVZ',type = 'xts')


  compareData <- data.frame()

  ### Some statistical parameters for analysis

  # Rolling Correlation
  #TTR::runCor(x =vix[,4] ,y = gold[,4],n =  63)

  # Overall Correlation

  # Regime breakdown

  # Volatility filter


}


