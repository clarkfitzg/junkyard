# How quickly does R fit an OLS linear regression model?
library(microbenchmark)

df = read.csv('simulated.csv', header = FALSE)
names(df)[1] = 'Y'

fit = lm(Y ~ ., data=df)
microbenchmark(lm(Y ~ ., data=df))
# 5.5 milliseconds
# Interesting, about 5 times slower than statsmodels and
# 20 times slower than Numpy

# Lets call the lower level code
y = as.matrix(df[, 1])
x = as.matrix(df[, 2:6])
lowfit = lm.fit(y, x)
microbenchmark(lm.fit(y, x))
# Right on- at 335 microseconds this is about the same as Numpy!

# From the scale of these low level coefficients it looks like R is
# doing some standardization / scaling beforehand
