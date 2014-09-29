# Accessing the Rotten Tomatoes API

library(RCurl)
library(RJSONIO)

tomato_url <- 'http://api.rottentomatoes.com/api/public/v1.0.json'

key <- scan('~/.rotten_tomatoes_key', what='')

loadjson <- function(target_url, .apikey=key, ...){
    # download and convert json from target_url into R vector
    # with ... parameters
    unlist(fromJSON(getForm(target_url, apikey=.apikey, ...)))
}

# first page
a <- loadjson(tomato_url)
# movies listing
#b <- loadjson(a[grep('movie', a)])
## movies, not dvds
#c <- loadjson(b[grep('movie', b)])
## movies in theaters now
#d <- loadjson(c[grep('in_theaters', c)])
#
    #raw_content <- getForm(tomato_url, apikey=key)

#firstpage <- unlist(fromJSON(raw_content))
