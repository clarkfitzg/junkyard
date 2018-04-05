# Tue Mar 13 15:39:38 PDT 2018
#
# Experimenting with the dash API for Vessela Engsberg
#
# Duncan's workshop on web scraping is a nice resource:
# http://dsi.ucdavis.edu/WebScraping/
#
# Authoritative reference for URL's:
# http://www.ietf.org/rfc/rfc2396.txt
#
# https://www.ibm.com/support/knowledgecenter/en/SSGMCP_5.1.0/com.ibm.cics.ts.internet.doc/topics/dfhtl_uricomp.html
#
# The manual has some Easter eggs- actually made me LOL. Literally the
# most entertaining API documentation I've ever read.
# https://dash.ucop.edu/api/docs/#/default/get_datasets__doi_
# Like chrome muffler bearings

library(RCurl)
library(RJSONIO)


# We don't need API's for simple things. For example, if I want to
# access a file from an R script I can find the URL by browsing the main
# page:
# https://dash.ucdavis.edu/stash/dataset/doi:10.25338/B8QC7F
# I can do something like the following:
# TODO: get
# Or just paste the URL into a browser
# https://dash.ucdavis.edu/stash/downloads/file_download/27666


base_url = "https://dash.ucop.edu"

ds_url = paste0(base_url, "/api/datasets")

raw = getURLContent(ds_url)

j = fromJSON(raw)

names(j)

# What is a link to the next and previous pages of results?
j[["_links"]]

# I think this is how many individual results
j[["count"]]

# How many total results?
j[["total"]]

# Then we see a bunch of stuff here.
j[["_embedded"]]

# Seemingly extraneous layer of nesting. Common.
# But this is an actual data object, we see familiar fields like title,
# authors, abstract.
names(j[["_embedded"]][[1]][[1]])

j[["_embedded"]][[1]][[1]][["id"]]


# Appears to be a URL for direct download
j[["_embedded"]][[1]][[1]][["_links"]][["stash:download"]]

j[["_embedded"]][[1]][[1]][["storage_size"]]


# If we want to go directly there:
rel_url = j[["_embedded"]][[1]][[1]][["_links"]][["self"]]

raw2 = getURLContent(paste0(base_url, rel_url))
j2 = fromJSON(raw2)

# Notice different between href and id.
# If I have the DOI and I want to access the record:

# This DOI is pretty cool. Maybe Vessela can explain what it means.
pems_doi = "DOI:10.25338/B8QC7F"

# This is the kind of gibberish we're after
pems_url = paste0(base_url, "/api/datasets/", URLencode(pems_doi, reserved = TRUE))

# All works great.
raw3 = getURLContent(pems_url)

j3 = fromJSON(raw3)


# How large are the datasets on Dash?
#
# We'll start by grabbing all the metadata for all the datasets.


get_dash_metadata = function(base_url = "https://dash.ucop.edu"
                             , first_path = "/api/datasets"
                             , seconds_between_requests = 0.1)
{
    # Start with the first response
    first_url = paste0(base_url, first_path)
    j = fromJSON(getURLContent(first_url))

    npages = ceiling(j[["total"]] / j[["count"]])

    # Only 1 page, no need to loop
    if(npages < 2) return(j[["_embedded"]][[1]])

    # Preallocate place for each page to go
    result = vector(npages, mode = "list")

    for(i in seq(npages)){
        result[[i]] = j[["_embedded"]][[1]]
        if(i < npages){
            nexturl = paste0(base_url, j[["_links"]][["next"]])
            Sys.sleep(seconds_between_requests)
            j = fromJSON(getURLContent(nexturl))
        }
    }

    # Eliminates nesting caused by API structure.
    do.call(c, result)
}


# Make a data frame with these columns
nested_to_table = function(x
    , columns = c("id", "title", "storage_size", "versionNumber")
){
    # dash wants to make it as easy as possible to upload your data. To
    # that end many fields will be missing data. Then it's up to you, the
    # one processing the metadata, to handle it correctly.
    # 
    # Practice for your data munging skills :)
    #
    if(!is.list(x)) x = as.list(x)
    x2 = x[columns]
    empty = sapply(x2, is.null)
    x2[empty] = NA
    out = do.call(data.frame, x2)
    colnames(out) = columns
    out
}


md = get_dash_metadata()

tmp = lapply(md, nested_to_table)

meta = do.call(rbind, tmp)

# Now we can look at the storage size
library(ggplot2)

# Useful for projector
theme_set(theme_bw(base_size = 20))

ggplot(meta, aes(x = storage_size)) +
    geom_histogram(bins = 20) +
    scale_x_log10() +
    labs(title = "Size of data sets in Dash") +
    labs(caption = "1e3 = KB, 1e6 = MB, 1e9 = GB, 1e12 = TB")

ggsave("sizes.pdf")
