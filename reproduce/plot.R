library(ggplot2)

loaded_data <- read.csv('data.csv')
x <- loaded_data[, 1]
y <- loaded_data[, 2]

pdf('figure.pdf', height=3, width=3)

print(qplot(x, y))

dev.off()
