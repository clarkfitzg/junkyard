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
n = 200
p = 5
x0 = matrix(runif(n*p), nrow=n)
# beta vector
betas = 1:p
y0 = 10 + x0 %*% betas + rnorm(n)

# All the model assumptions are satisfied- makes for a nice fit
fit1 = lm(y0 ~ x0)
summary(fit1)

#============================================================

# Some helper functions

issmall = function(x, epsilon=1e-5) abs(x) < epsilon

ytransform = function(y, lambda){
    #
    # Acts on the y vector given scalar lambda
    #
    if(issmall(lambda)){
        new_y = log(y)
    }
    else{
        new_y = y ** lambda
    }
    # return the normalized vector
    new_y / norm(new_y, '2')
}

xtransform = function(x, lambda){
    #
    # Acts on single x vector given scalar lambda
    #
    if(issmall(lambda)){
        log(x)
    }
    else{
        x ** lambda
    }
}

#============================================================

# Now lets code the optimization

# The geometric mean aka ydot
y. = prod(y) ** (1/n)

xdf = as.data.frame(x0)

objective = function(lambda){
    # The objective function to minimize over the lambda vector
    # We continually refer to original y0 and x0
    y = ytransform(y0, lambda[1])
    x = Map(xtransform, xdf, lambda[-1])
    x = do.call(cbind, x)
    fit = lm(y ~ x)
    residuals(fit)
}

lambda0 = rep(1, p + 1)

out = nls.lm(lambda0, fn=objective)

# Now we have the transformed data
tdata = Map(xtransform, cbind(y, xdf), out$par)
tdata = data.frame(do.call(cbind, tdata))
tfit = lm(y ~ ., tdata)
summary(tfit)
