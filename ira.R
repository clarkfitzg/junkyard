# Annual return rate on VTI ETF for 2007 to 2016
vti = c(5.37, -36.98, 28.89, 17.42, 0.97, 16.45, 33.45, 12.54, 0.36, 12.83)

# About 9%
vti_rate = mean(vti)


#' How much will an investment be worth after many years?
#'
#' Computes value in today's 1000's of dollars
#'
#' @param contrib annual contribution
#' @param rr average annual return rate (percent)
#' @param start starting value of account
#' @param yrs number of years before withdrawl
#' @param inflation average inflation rate (percent)
invest = function(rr = vti_rate, contrib = 5, start = 100, yrs = 30, inflation = 2)
{
    growthrate = rr - inflation
    total = start
    for(i in seq(yrs)){
        total = total + total * growthrate / 100 + contrib
    }
    total
}

ira = expand.grid(contrib = c(0, 3, 5.5), rr = 4:11)
ira$value1 = mapply(invest, ira$rr, ira$contrib, start = 127)
ira$value2 = mapply(invest, ira$rr, ira$contrib, start = 27)

# Starting with this amount, contributing 5.5K every year will add value
# between 220K-750K 

edu = data.frame(rr = 4:11)
edu$value = sapply(edu$rr, invest, start = 60, yrs = 16)
