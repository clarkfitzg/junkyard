library(ggplot2)
theme_set(theme_gray(base_size=20))

normal = rnorm(100)

pdf('figs/normal.pdf')
print(qplot(normal))
dev.off()
