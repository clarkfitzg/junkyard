library(RCurl)
library(XML)

columns = c("price", "oldprice", "page", "site", "description")



extract = function(nodeset, xpath)
{
    sapply(nodeset, function(x) xpathSApply(x, xpath, xmlValue))
}


price_to_num = function(price) as.numeric(gsub("\\$", "", price))


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

revole = function(page = 1, ...)
{

    baseurl = "http://www.revolve.com/dresses/br/a8e981/"
    raw = getForm(baseurl, pageNum = page, ...)
    doc = htmlParse(raw)


    <ul id="plp-prod-list" class="g products-grid u-margin-b--xxl block-grid--inline n-block-grid--3">

    description = xpathSApply(doc, "//div[@class = 'plp-name h1 product-titles__name product-titles__name--sm u-margin-b--none js-plp-name']", xmlValue)

    price = xpathSApply(doc, "//span[@class = 'plp_price prices__retail']", xmlValue)

    <span class="plp_price prices__retail">$98</span>

    # Working now, I think with 71 items
    products = getNodeSet(doc, "//div[@class = 'product-list-item']")


revolve = 


# Resisting:

    #baseurl = "https://www.macys.com/shop/womens-clothing/dresses/Productsperpage/120"
    #raw = getForm(baseurl, id = 5449)

    #baseurl = "https://www.express.com/womens-clothing/dresses/cat550007"
    #raw = getURL(baseurl)


scrape = function(scraper, pages, try = TRUE, sleeptime = 1)
{
    tryscraper = function(page, ...){
        out = try(scraper(page, ...))
        Sys.sleep(sleeptime)
        if(is(out, "try-error"))
            NULL
        else
            out
    }
    s = if(try) tryscraper else scraper

    # Use the same handle for all requests
    curl = getCurlHandle()
    out = lapply(pages, s, curl = curl)
    do.call(rbind, out)
}


# Tests
if(FALSE){

l2 = lulus(2)

ll = scrape(lulus, 16:17)


a3 = asos(37)

aa = scrape(asos, 22:23)


# Looks like tobi saw the robot
# <!DOCTYPE html>
# <html>
# <head>
# <meta name="ROBOTS" content="NOINDEX, NOFOLLOW">

t2 = tobi(2)
tt = scrape(tobi, 1:2, try = FALSE)

tt = scrape(tobi, 1:2)

}
