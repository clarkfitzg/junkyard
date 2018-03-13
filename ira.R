# Annual return rate on VTI ETF for 2007 to 2016
vti = c(5.37, -36.98, 28.89, 17.42, 0.97, 16.45, 33.45, 12.54, 0.36, 12.83)

# About 9%
vti_rate = mean(vti)


#' How much will an investment be worth after many years?
#'
#' Computes value in today's 1000's of dollars
#'
#' @param contrib vector of annual contributions
#' @param rr vector of average annual return rate (percent)
#' @param start vector starting value of account
#' @param yrs scalar number of years before withdrawl
#' @param inflation vector average inflation rate (percent)
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
ira$v1 = invest(ira$rr, ira$contrib, start = 130)
ira$v2 = invest(ira$rr, ira$contrib, start = 21)

# Starting with this amount, contributing 5.5K every year will add value
# between 220K-750K 

print(ira)


edu = data.frame(rr = 4:11)
edu$v = invest(edu$rr, contrib = 0, start = 74.4, yrs = 16)

print(edu)
