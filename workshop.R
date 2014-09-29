# Notes from Duncan's web scraping workshop

library(XML)

u = 'http://en.wikipedia.org/wiki/List_of_countries_by_population'

tt = readHTMLTable(u, stringsAsFactors=FALSE,
    colClasses=c('integer', 'character', 'FormattedNumber', 'character',
                 'character'),
    which=1
) 
