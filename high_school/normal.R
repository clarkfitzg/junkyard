library(ggplot2)

set.seed(37)

n <- 10000

df <- data.frame(x=rnorm(n), y=rnorm(n))

pdf('normal.pdf')

p <- ggplot(df, aes(x=x, y=y)) + stat_binhex()

print(p)

dev.off()
