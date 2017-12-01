source("tools.R")

scrapers = list(lulus = lulus, asos = asos, revolve = revolve)
pages = list(lulus = 1:28, asos = 1:37, revolve = 1:73)

# Test without doing the whole thing
#pages = list(lulus = 7:8, asos = 1:3, revolve = 2:4)

raw = Map(scrape, scrapers, pages)

dress = do.call(rbind, raw)

table(dress$site)

write.csv(dress, "~/data/dress.csv", row.names = FALSE)
