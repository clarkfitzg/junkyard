source("tools.R")

scrapers = list(lulus = lulus, asos = asos, tobi = tobi)
npages = c(lulus = 28, asos = 37, tobi = 33)

dress = Map(scrape, scrapers, npages)
