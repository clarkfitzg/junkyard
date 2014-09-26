# Scraping hacker news

library(RCurl)
library(XML)

# readHTMLTable is a very convenient function
#iso_codes <- readHTMLTable('http://en.wikipedia.org/wiki/ISO_3166-1')[[1]]

hn <- htmlParse(getURLContent('https://news.ycombinator.com/'))

headlines <- xpathSApply(hn, "//td[@class='title']/a", xmlValue)

digit_news <- headlines[grep('[0-9]', headlines)]
