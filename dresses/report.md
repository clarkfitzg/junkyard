Thu Nov 30 10:28:54 PST 2017

Thinking about a totally different type of parallel task, or rather one
with very different performance characteristics than numeric computing.

Idea: Start to understand the different online fashion retailers.

On Google I search for "dresses". I click on all the links and pull a fixed
number of dresses from each website.


Fri Dec  1 14:56:11 PST 2017

Actually performed the scrape.

```{R}

# Make sure the logic was correct for sale prices
with(dress, any(oldprice < price))

dress$sale = with(dress, price < oldprice)

dress$percent_off = with(dress, 100 * (1 - price/oldprice))


# What fraction of the inventory is on sale?
tapply(dress$sale, dress$site, mean)

# How much are the sales marked down?
with(dress[dress$sale, ], tapply(percent_off, site, median))

# What's the range of the prices?
boxplot(price ~ site, dress[dress$price < 800, ], ylab = "price ($)", xlab = "site")

# With a little better resolution:
boxplot(price ~ site, dress[dress$price < 300, ], ylab = "price ($)", xlab = "site")


# What's the distribution of the low priced dresses?
lp = dress[dress$price < 200, ]

library(lattice)

histogram(~ price | site, lp, main = "distribution of dress prices below $200")

```
