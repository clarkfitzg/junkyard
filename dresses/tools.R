library(RCurl)
library(XML)

columns = c("price", "oldprice", "page", "store", "description")

npages = c(lulus = 28, asos = 37, tobi = 33)


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
    oldprice = extract(products, "(.//span[@class = 'price'])[1]")

    price = extract(products, "(.//span[@class = 'sale'])[1]")

    description = extract(products, "(.//h3/a[@href])[1]")

    out = data.frame(price = price_to_num(price)
                     , oldprice = price_to_num(oldprice)
                     , page = page
                     , site = "lulus"
                     , description = description
                     )
    out
}


asos = function(page = 1)
{

    baseurl = "http://us.asos.com/women/dresses/cat/"
    raw = getForm(baseurl, cid = 8799, pge = page - 1, pgesize = 204)
    #raw = getForm(baseurl, cid = 8799, pgesize = 204, sort ="priceasc")
    doc = htmlParse(raw)

    description = xpathSApply(doc, "//span[@class = 'name']", xmlValue)

    price = xpathSApply(doc, "//div[@class = 'price-wrap price-current']/span[@class = 'price']", xmlValue)
    price = price_to_num(price)

    oldprice = xpathSApply(doc, "//div[@class = 'price-wrap price-previous']/span[@class = 'price']", xmlValue)
    oldprice = price_to_num(oldprice)

    nochange = is.na(oldprice)

    oldprice[nochange] = price[nochange]

    out = data.frame(price = price
                     , oldprice = oldprice
                     , page = page
                     , store = "asos"
                     , description = description
                     )
    out
}


tobi = function(page = 1)
{

    baseurl = "http://www.tobi.com/dresses"
    raw = getForm(baseurl, page = page)
    doc = htmlParse(raw)

    # Working now, I think with 71 items
    products = getNodeSet(doc, "//div[@class = 'product-list-item']")

    description = extract(products, "(.//span[@class = 'item-color-name'])[1]")

    retail = extract(products, ".//span[@class = 'retail-price']")

    oldprice = extract(products, ".//span[@class = 'original-price']")
    oldprice = Map(c, retail, oldprice)
    oldprice = sapply(oldprice, function(x) x[[1]])

    price = extract(products, ".//span[@class = 'sale-price']")
    price = Map(c, price, retail)
    price = sapply(price, function(x) x[[1]])

    out = data.frame(price = price_to_num(price)
                     , oldprice = price_to_num(oldprice)
                     , page = page
                     , store = "tobi"
                     , description = description
                     )
    out

}


# Resisting:

    #baseurl = "https://www.macys.com/shop/womens-clothing/dresses/Productsperpage/120"
    #raw = getForm(baseurl, id = 5449)

    #baseurl = "https://www.express.com/womens-clothing/dresses/cat550007"
    #raw = getURL(baseurl)


# Tests
if(FALSE){

l2 = lulus(2)

a3 = asos(37)

t2 = tobi(2)

}
