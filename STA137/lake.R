lake = read.csv('lake.dat', header=FALSE, col.names='level')
lake$t = 1:nrow(lake)
dim(lake)
attach(lake)

plot(t, level)
lines(t, level)

mod2 = lm(level ~ poly(t, 2), data=lake)
summary(mod2)
anova(mod2)
# Bummer that the anova table doesn't show each one
anova(lm(level ~ t + I(t**2), data=lake))
summary(lm(level ~ t + I(t**2), data=lake))
# So quadratic is definitely helping here.

points(mod2$fitted.values, col='red')

mod3raw = lm(level ~ poly(t, 3, raw=TRUE), data=lake)
summary(mod3raw)
points(mod3raw$fitted.values)

# qqplot is reasonable
# residuals show some patterns

mod3orth = lm(level ~ poly(t, 3), data=lake)
summary(mod3orth)
points(mod3orth$fitted.values, col='blue', pch='x')

# Surprising how different the regression coefficients are depending on
# whether you use orthogonal polynomials or not.
# I expect that the orthogonal part contributes to numerical stability.
# Orthogonal is also very appealing for the lm because it implies that the
# design matrix is also orthogonal

p = poly(level, 3)
dim(p)
cor(p)

plot(t, mod3orth$residuals, type='l')
# Variance does appear to be increasing
lines(t, mod2$residuals, type='l', col='red')
# Basically the same
hist(mod2$residuals)

# overall not that bad

max(abs(mod3raw$fitted.values - mod2$fitted.values))

lts = ts(lake$level, start=1874)
