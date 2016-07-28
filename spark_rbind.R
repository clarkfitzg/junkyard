n = 3
df = data.frame(key = 1:n)
df$value = lapply(letters[1:n], serialize, connection = NULL)
#df$value = 1:n + 5

# Convert df to list
args <- list(FUN = list, SIMPLIFY = FALSE, USE.NAMES = FALSE)
df_as_list <- do.call(mapply, append(args, df))

# Clark: but this is a list of lists. For rbind to make sense it should be
# a list of rows, which is a list of dataframes

# Dataframes are lists by their columns. So by transposing maybe we can
# make it into a list of rows
rowlist = (data.frame(t(df)))

# Same problem
rowlist = apply(df, 1, function(x) x)


rowlist = split(df, 1:nrow(df))

df2 = do.call(rbind, rowlist)

args <- list(FUN = data.frame, SIMPLIFY = FALSE, USE.NAMES = FALSE)
df_row_list <- do.call(mapply, append(args, df))

# Convert list back to df. This gives an error
df2 <- do.call(rbind, df_as_list)

df2 <- do.call(rbind.data.frame, df_as_list)

df3 = as.data.frame(df2)

sapply(df3, class)

