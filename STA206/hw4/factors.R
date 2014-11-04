# How does R handle factors in model formulae?

############################################################
# Setup

set.seed(931)

dfnum = data.frame(y = runif(100), x = rep(c('a', 'b'), 50), 
                    x2 = rep(c(5, 4, 3, 2, 1), 20))
dffact = dfnum
dffact$x2 = as.factor(dffact$x2)
# Force it into character string
dfchar = dffact
dfchar$x = as.character(dfchar$x)

sapply(dffact, class)
sapply(dfchar, class)

xnum = data.frame(y = c(1, 3), x = c('b', 'a'), x2 = c(4, 3))
xint = xnum
xint$x2 = as.integer(xint$x2)
xfact = xnum
xfact$x2 = as.factor(xfact$x2)
xchar = xfact
xchar$x = as.character(xchar$x)

sapply(xnum, class)
sapply(xfact, class)
sapply(xchar, class)


# Experiments 
############################################################

# R does the right thing, even when coercing to character
mod1 = lm(y ~ x + x2, dfchar)
predict(mod1, xchar, interval = 'confidence')
summary(mod1)

# Include a call to `factor` in the formula
# Again R does the right thing
mod2 = lm(y ~ factor(x) + x2, dfchar)
predict(mod2, xchar, interval = 'confidence')
#predict(mod2, xint, interval = 'confidence')

mod3 = lm(y ~ factor(x) + factor(x2), dfnum)
predict(mod3, xnum, interval = 'confidence')
predict(mod3, xint, interval = 'confidence')

# We expect this to differ from the others
# Indeed it is, because x2 is treated as numeric.
mod4 = lm(y ~ factor(x) + x2, dfnum)
predict(mod4, xnum, interval = 'confidence')

# Summary
############################################################
# R's lm and predict methods are surprisingly resilient to problems 
# stemming from different data types.
# We tried strings, factors, floats, and integer inputs.
