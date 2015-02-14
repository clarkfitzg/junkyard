# Simulaneous variable transforms
# 
# Following Prabir Burman's instructions
# Stats 207
#
# Tue Feb 10 20:10:28 PST 2015

library(minpack.lm)


# As a first test lets feed it the model as expected and see if it can find
# the identity

set.seed(12)
n = 400
p = 6
x0 = matrix(5 + rnorm(n*p), nrow=n)
# beta vector
betas = 1:p
y0 = 10 + x0 %*% betas + rnorm(n)

# Now we'll try when some transforms are needed.
# Raise y0 to exponential
y0 = exp(y0)

# Square x2
x0[, 2] = x0[, 2] ** 2

# Now for the cars data
if (T){
    set.seed(30)
    library(xlsx)
    cars = xlsx::read.xlsx('cars93.xlt', 1)

    y0 = cars$Price
    x0 = as.matrix(cars[, 2:7])
}

# All the model assumptions are satisfied- makes for a nice fit
fit1 = lm(y0 ~ x0)
summary(fit1)
anova(fit1)

#============================================================

# Some helper functions

issmall = function(x, epsilon=1e-2) abs(x) < epsilon

geomean = function(x){
    # The geometric mean aka xdot
    # Need to code it this way so it doesn't overflow
    exp(mean(log(x)))
}

ytransform = function(y, lambda, ydot){
    #
    # Acts on the y vector given scalar lambda and geometric mean ydot
    #
    if(issmall(lambda)){
        new_y = ydot * log(y)
    }
    else{
        new_y = (y ** lambda - 1) / (lambda * ydot ** (lambda - 1))
    }
    return(new_y)
}

xtransform = function(x, lambda){
    #
    # Acts on single x vector given scalar lambda
    #
    if(issmall(lambda)){
        log(x)
    }
    else{
        x ** lambda / lambda
    }
}

#============================================================

# Optimization

y. = geomean(y0)

xdf = as.data.frame(x0)

objective = function(lambda){
    # The objective function to minimize over the lambda vector
    # We continually refer to original y0 and x0
    y = ytransform(y0, lambda[1], y.)
    x = Map(xtransform, xdf, lambda[-1])
    x = do.call(cbind, x)
    fit = lm(y ~ x)
    residuals(fit)
}

# Initial value
lambda0 = rnorm(p + 1, mean=1, sd=0.05)

t1 = objective(lambda0)

con = nls.lm.control(maxiter=1000, maxfev=4000)
out = nls.lm(lambda0, fn=objective, control=con)

# Now we have the transformed data
tdata = Map(xtransform, cbind(y0, xdf), out$par)
tdata = data.frame(do.call(cbind, tdata))
tfit = lm(y0 ~ ., tdata)
summary(tfit)
anova(tfit)

parms = data.frame(name = names(tdata), transformation = out$par)
print(parms)
