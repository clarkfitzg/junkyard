library(RCurl)
library(XML)

columns = c("price", "oldprice", "page", "site", "description")


# Still doesn't help with the tobi site
options(HTTPUserAgent = "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36")


extract = function(nodeset, xpath)
{
    sapply(nodeset, function(x) xpathSApply(x, xpath, xmlValue))
}


price_to_num = function(price) as.numeric(gsub("[^0-9^\\.]", "", price))


lulus = function(page = 1, ...)
{
    baseurl = sprintf("https://www.lulus.com/categories/page%i-60/13/dresses.html", page)
    raw = getURL(baseurl, ...)
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


asos = function(page = 1, ...)
{

    baseurl = "http://us.asos.com/women/dresses/cat/"
    raw = getForm(baseurl, cid = 8799, pge = page - 1, pgesize = 204, ...)
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
                     , site = "asos"
                     , description = description
                     )
    out
}


tobi = function(page = 1, ...)
{

    baseurl = "http://www.tobi.com/dresses"
    raw = getForm(baseurl, page = page, ...)
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
                     , site = "tobi"
                     , description = description
                     )
    out

}


revolve = function(page = 1, ...)
{

    baseurl = "http://www.revolve.com/dresses/br/a8e981/"
    raw = getForm(baseurl, pageNum = page, ...)
    doc = htmlParse(raw)

    products = getNodeSet(doc, "//ul[@id = 'plp-prod-list']/*")

    description = extract(products, ".//div[contains(@class, 'plp-name h1 product-titles')]")

    retail = extract(products, ".//span[@class = 'plp-price-retail prices__retail--strikethrough js-plp-price-retail']")
    price = extract(products, ".//span[@class = 'plp_price prices__retail']")
    sale = extract(products, ".//span[@class = 'plp-price prices__markdown js-plp-price']")

    oldprice = Map(c, retail, price)
    oldprice = sapply(oldprice, function(x) x[[1]])

    price = Map(c, sale, price)
    price = sapply(price, function(x) x[[1]])

    out = data.frame(price = price_to_num(price)
                     , oldprice = price_to_num(oldprice)
                     , page = page
                     , site = "revolve"
                     , description = description
                     )
    out
}



# Resisting:

    #baseurl = "https://www.macys.com/shop/womens-clothing/dresses/Productsperpage/120"
    #raw = getForm(baseurl, id = 5449)

    #baseurl = "https://www.express.com/womens-clothing/dresses/cat550007"
    #raw = getURL(baseurl)


scrape = function(scraper, pages, try = TRUE, sleeptime = 2)
{
    Sys.sleep(sleeptime)
    tryscraper = function(page, ...){
        out = try(scraper(page, ...))
        if(is(out, "try-error"))
            NULL
        else
            out
    }
    s = if(try) tryscraper else scraper

    # Use the same handle for all requests to the same site
    curl = getCurlHandle()
    out = lapply(pages, s, curl = curl)
    out = do.call(rbind, out)
    out$position = seq(nrow(out))
    out
}


# Tests
if(FALSE){

l2 = lulus(2)

ll = scrape(lulus, 16:17)


a3 = asos(37)

aa = scrape(asos, 22:23)


r2 = revolve(2)

r22 = scrape(revolve, 22:23)


# Looks like tobi sees the robot after the 3rd time or so:
# <!DOCTYPE html>
# <html>
# <head>
# <meta name="ROBOTS" content="NOINDEX, NOFOLLOW">

t2 = tobi(2)

tt = scrape(tobi, 1:2, try = FALSE)

tt = scrape(tobi, 1:2, sleeptime = 5)



price_to_num("Sale price $56")
price_to_num("$56")
price_to_num("$22.5")

}
