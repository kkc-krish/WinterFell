# ## Stock above 10day SMA and below 50day SMA
# ## Avg Vol 5D/10D is > 1
#
# univsp500 <- tq_index(x = 'SP500')$symbol
# univR1000 <- tq_index(x = 'RUSSELL1000')$symbol
# univR3000 <- tq_index(x = 'RUSSELL3000')$symbol
#
#
# sp500_hist = lapply(univsp500, function(x) tryCatch(getSymbols(x, auto.assign = F), error = function(e) print(e)))
# saveRDS(sp500_hist, 'sp500hist.rds')
#
# R1000_hist = lapply(univR1000, function(x) tryCatch(getSymbols(x, auto.assign = F), error = function(e) print(e)))
# saveRDS(sp500_hist, 'R1000_hist.rds')
#
#
# R3000_hist = lapply(univR3000, function(x) tryCatch(getSymbols(x, auto.assign = F), error = function(e) print(e)))
# saveRDS(sp500_hist, 'R3000_hist.rds')
