x = rnorm(10)
write.table(x, "normal.txt", row.names = FALSE, col.names = FALSE)

y = rnorm(1e8)
write.table(y, "bignormal.txt", row.names = FALSE, col.names = FALSE)
