set.seed(328)

# 1a
############################################################
n = 100
x1 = rnorm(n)
x2 = rnorm(n)
x3 = rnorm(n)
y = 4 * x1 + rnorm(n)

mod1 = lm(y ~ x1)
mod2 = lm(y ~ x2 + x3)

# 1b
############################################################
n = 100
x1 = rnorm(n)
y = rep(10, n)

mod1 = lm(y ~ x1)

# 1k
############################################################
# Does the magnitude of a standardized regression coefficient
# reflect the comparitive importance?

n = 100
df = data.frame(x1 = runif(n))
df$y = 400 + 2 * df$x1 + 0.001 * rnorm(n)
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

#x2 = rnorm(n)
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

# 4a
############################################################

Xfirst4 = matrix(c(rep(1, 4), 0.36, 0.66, 0.66, -0.52,
                   2.14, 0.74, 1.91, -0.41), nrow=4)
# Add interaction term
Xfirst4 = cbind(Xfirst4, Xfirst4[, 2] * Xfirst4[, 3])
Xfirst4

# 4b
############################################################

XtXinv = matrix(c(0.087, -0.014, -0.035, -0.004,
                  -0.014, 0.115, -0.012, -0.052,
                  -0.035, -0.012, 0.057, -0.014,
                  -0.004, -0.052, -0.014, 0.050), nrow=4)

# From ANOVA table
MSE = 1.040
degfree = 26

# Predicted value for x1 = 0, x2 = 0 is b0 from summary
predvalue = 0.9918
predvalue

# Prediction standard error at this point
xh = c(1, 0, 0, 0)
predse = sqrt(MSE * (1 + xh %*% XtXinv %*% xh))
predse

# A 95% prediction interval
t95 = qt(0.975, degfree)
interval = c(predvalue - t95, predvalue + t95) * predse
interval

# 4c
############################################################
# Compute sums of squares from the the ANOVA table

SSR = 58.232 + 5.490 + 0.448
SSR
SSE = 27.048
SSTO = SSR + SSE
SSTO

# 4d
############################################################

# Read SSR(x1) from ANOVA
SSR.x1 = 58.232

# SSE(x1)
SSE.x1 = SSTO - SSR.x1
SSE.x1

# Read SSR(x2 | x1) from ANOVA
SSR.x2.given.x1 = 5.490
SSR.x2.given.x1 

# SSR(x2, x1*x2 | x1)
5.490 + 0.448

# SSR(x1*x2 | x1, x2)
0.448

# SSR(x1, x2)
SSR.x1.x2 = 58.232 + 5.490
SSR.x1.x2

# SSE(x1, x2)
SSE.x1.x2 = SSTO - SSR.x1.x2
SSE.x1.x2

# 4e
############################################################
# Coefficients of partial determination

# R2 y, x2 | x1 = SSR(x2 | x1) / SSE(x1)
R2.given.x1 = SSR.x2.given.x1 / SSE.x1
R2.given.x1 

# R2 y, x1*x2 | x1, x2 = SSR(x1*x2 | x1, x2) / SSE(x1, x2)
R2.given.x1.x2 = 0.448 / SSE.x1.x2

# Partial correlation Ry, x1*x2 | x2, x1
# Sign comes from the coefficient of x1*x2 term in model summary
-sqrt(R2.given.x1.x2)

# 4f
############################################################









fstar = (5.49 + 0.448) / MSE
fstar
f99 = qf(c(0.005, 0.995), 2, 26)
f99
