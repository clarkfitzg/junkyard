f = function(...){
    dots = list(...)
    browser()
}

a = f(1:5, letters)

b = f(1:5)

library(ddR)

n = 10
x = 1:n
y = rnorm(n)
df = data.frame(degree = 1:3)
df$model = lapply(df$degree, function(degree) lm(y ~ poly(x, degree)))

df$model[[1]]

ddf = as.dframe(df)

collect(ddf)
