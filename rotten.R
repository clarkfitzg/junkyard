# Accessing the Rotten Tomatoes API

library(RCurl)

tomato_url <- 'http://api.rottentomatoes.com/api/public/v1.0.json'

key <- readChar('~/.rotten_tomatoes_key', 24)

firstpage <- postForm(tomato_url, apikey=key)
