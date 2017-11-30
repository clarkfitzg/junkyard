library(RCurl)
library(XML)


extract = function(nodeset, xpath)
{
    sapply(nodeset, function(x) xpathSApply(x, xpath, xmlValue))
}


raw = getURL("https://www.lulus.com/categories/13/dresses.html")
doc = htmlParse(raw)

# Products are all children of product-list
products = getNodeSet(doc, "//div[@id = 'product-list']/*")

# We only want the first price
price = extract(products, "(.//span[@class = 'price'])[1]")

description = extract(products, ".//a[@href]")
