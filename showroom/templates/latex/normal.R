library(ggplot2)

pdf('normal_R.pdf')
qplot(rnorm(1000))
dev.off()
