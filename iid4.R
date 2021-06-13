
p2 = function(x, ylab = "observed value", xlab = "index", ...) plot(x, ylab = ylab, xlab = xlab, ...)

set.seed(24789)

n = 50
x = seq(n)

png("~/Desktop/random4.png")

par(mfrow = c(2,2))
p2(rnorm(n), main = "A")
p2(0.1*x + rnorm(x), main = "B")
p2(sin(pi * x/50) + rnorm(x, sd = 0.15), main = "C")
p2(rnorm(n, sd = x), main = "D")

dev.off()
