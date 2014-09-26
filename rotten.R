# Accessing the Rotten Tomatoes API

library(RCurl)
library(RJSONIO)

tomato_url <- 'http://api.rottentomatoes.com/api/public/v1.0.json'

key <- scan('~/.rotten_tomatoes_key', what='')

raw_content <- getForm(tomato_url, apikey=key)

firstpage <- unlist(fromJSON(raw_content))
