# Notes from Duncan's web scraping workshop

library(XML)

u = 'http://en.wikipedia.org/wiki/List_of_countries_by_population'

if (FALSE){
    tt = readHTMLTable(u, stringsAsFactors=FALSE,
        colClasses=c('integer', 'character', 'FormattedNumber', 'character',
                     'character'),
        which=1
    ) 

u2 = 'http://latimesblogs.latimes.com/washington/2009/07/sonia-sotomayor-hearing-transcript.html'

#txt = readLines(u2)
doc = htmlParse(txt)
r = xmlRoot(doc)


paras = getNodeSet(r, '//l')
ll = getNodeSet(doc, '//a[(@href)]')
}

walmart = 'http://www.walmart.com/ip/Folgers-Medium-Classic-Roast-Ground-Coffee-33.9-oz/11964630'

#doc = htmlParse(walmart)

walpath = '//*[@id="WM_PRICE"]/div/div/span/span[2]'

price = '//*[@id="WM_PRICE"]/div/div/span/span'

n = getNodeSet(doc, price)

