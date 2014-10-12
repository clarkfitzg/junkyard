library(testthat)

set.seed(253)

# Plotting parameter - sets bottom, left, top, right margin size
par(mai=c(0.8,0.6,0.1,0.4))

n = 30

b0 = 10
b1 = 0.5
noise = rnorm(n)

x = runif(n)

# The true linear model
y = b0 + b1 * x + noise

mod = lm(y ~ x)

pdf('regress.pdf', width = 5, height = 4)

plot(x, y)

# Plot the mean
points(mean(x), mean(y), pch = 16, cex = 2, col = 'blue')

# True line
abline(b0, b1, lty = 2, col = 'red')

# Fitted line
abline(mod)

# Verify that model does pass through mean of data
xbar = data.frame(x = mean(x))
# Need to work on this one.
#expect_equal(mean(y), predict(mod, xbar))

dev.off()
