library(RCurl)
library(XML)

columns = c("description", "price", "sale")


extract = function(nodeset, xpath)
{
    sapply(nodeset, function(x) xpathSApply(x, xpath, xmlValue))
}


price_to_num = function(price) as.numeric(gsub("\\$", "", price))


lulus = function(page = 1)
{
    baseurl = sprintf("https://www.lulus.com/categories/page%i-60/13/dresses.html", page)
    raw = getURL(baseurl)
    doc = htmlParse(raw)

    # Products are all children of product-list
    products = getNodeSet(doc, "//div[@id = 'product-list']/*")

    # We only want the first price
    price = extract(products, "(.//span[@class = 'price'])[1]")

    sale = extract(products, "(.//span[@class = 'sale'])[1]")

    description = extract(products, "(.//h3/a[@href])[1]")

    out = data.frame(description = description
                     , price = price_to_num(price)
                     , sale = price_to_num(sale)
                     )
    out
}

l2 = lulus(2)




    baseurl = "http://us.asos.com/women/dresses/cat/"
    raw = getForm(baseurl, cid = 8799, pgesize = 204)
    doc = htmlParse(raw)

    description = xpathSApply(doc, "//span[@class = 'name']", xmlValue)

    current_price = xpathSApply(doc, "//div[@class = 'price-wrap price-current']/span[@class = 'price']", xmlValue)
    current_price = price_to_num(current_price)

    previous_price = xpathSApply(doc, "//div[@class = 'price-wrap price-previous']/span[@class = 'price']", xmlValue)
    previous_price = price_to_num(previous_price)
