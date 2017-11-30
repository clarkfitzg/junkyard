library(RCurl)
library(XML)


extract = function(nodeset, xpath)
{
    prices = sapply(products, function(x) xpathSApply(x, "(.//span[@class = 'price'])[1]", xmlValue))
}

raw = getURL("https://www.lulus.com/categories/13/dresses.html")
doc = htmlParse(raw)

# Products are all children of product-list
products = getNodeSet(doc, "//div[@id = 'product-list']/*")

# We only want the first price
    prices = sapply(products, function(x) xpathSApply(x, "(.//span[@class = 'price'])[1]", xmlValue))

brand = xpathSApply(doc, "*h3[@class = 'brand']", xmlValue)

//*[@id="swatch-565252-565252"]/div[2]

