# 1k
############################################################
# Does the magnitude of a standardized regression coefficient
# reflect the comparitive importance?

set.seed(328)
n = 100
df = data.frame(x1 = runif(n))
df$y = 400 + 2 * x1 + 0.001 * rnorm(n)
df$noise = 1e-10 * rnorm(n)
mod = lm(y ~ x1 + noise, data = df)
s = summary(mod)

# With standardized variables
mod_standard = lm(scale(y) ~ scale(x1) + scale(noise), data = df)
s_standard = summary(mod_standard)

# 1n
############################################################
# Create two numerically uncorrelated vectors

y = rep(0, n)
y[sample.int(n, size=n/2)] = 1
y[y == 1][sample.int(n/2, size=n/4)] = -1

# x will be uncorrelated with y
x = rep(1, n)
x[y != 0] = 0
x[x == 1][sample.int(n/2, size=n/4)] = -1

x2 = rnorm(n)
mod1n = lm(y ~ x + x2)
s1n = summary(mod1n)
# Observe that beta1 is not 0.

# 1o
############################################################
# Update our vectors from before

# x2 is not correlated with x1
x2 = y
x2[x2 != 0] = 1
x2[x2 == 1][sample.int(n/2, size=n/4)] = -1

# changing centers won't make them correlated
x = x + 10
x2 = x2 + 40
y = y - 100

mod1o = lm(y ~ x + x2)
s10 = summary(mod1o)
