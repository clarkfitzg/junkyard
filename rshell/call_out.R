# Call another program through the command line from R

counts = system2("python", "counter.py", stdout = TRUE)

counts = as.integer(counts)
