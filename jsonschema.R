library(RJSONIO)

s = list(nchunks = 17, random_order = TRUE, nrows = 175, ncols = 2, NA_exist = FALSE,
         chunks = list("c1" = list(nrows = 10, filename = "x1.txt")
                       , "c2" = list(nrows = 10, filename = "x2.txt"))
         )

writeLines(toJSON(s), "schema.json")
