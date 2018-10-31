library(XLConnect)

prices0 = XLConnect::readWorksheetFromFile("prices.xls", 1L)

badcols = c(1:2, 54:57)
county_row = 7

thousands = function(x) as.numeric(gsub("[\\$,]", "", x)) / 1000

county = as.character(prices0[county_row, -badcols])
price = prices0[nrow(prices0), -badcols]
price = thousands(price)
prices = data.frame(county, price)

income = read.csv("income.csv", stringsAsFactors = FALSE)
income = income[, c("County", "Median.Income", "Population")]
colnames(income) = c("county", "income", "population")
income[, "income"] = thousands(income[, "income"])

d = merge(income, prices)

with(d, plot(income, price))

d$ratio = with(d, price / income)

d = d[order(d$ratio), ]

hist(d$ratio)

# https://medium.com/@urban_institute/how-to-create-state-and-county-maps-easily-in-r-577d29300bb2
