source("tools.R")

scrapers = list(lulus = lulus, asos = asos, tobi = tobi)
pages = list(lulus = 1:28, asos = 1:37, tobi = 1:33)

# For testing
pages = list(lulus = 1:2, asos = 1:3, tobi = 2:4)

raw = Map(scrape, scrapers, pages)

dress = do.call(rbind, raw)
