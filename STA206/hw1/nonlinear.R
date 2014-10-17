n = 100
x = runif(n, max=3 * pi)
y = 8 * sin(x) + rnorm(n)

mod = lm(y ~ x)

pdf('nonlinear.pdf', width = 5, height = 4)

plot(x, y)

# Fitted line
abline(mod, lty=2)

dev.off()
