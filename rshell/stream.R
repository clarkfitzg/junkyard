# Process data as a stream, ie. without loading into memory
# Using system pipes (not to be confused with magrittr::%>%)

# TASK: Find numbers beginning with 2"

# Makes a file-like object
p_in <- pipe('grep "^2" bignormal.txt', "r")

x = read.table(p_in)

close(p_in)
