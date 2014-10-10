# So what happens when the errors are in fact correlated?
#
# In this case the data still comes from a linear relationship

err = rep(rnorm(10), 10) + 0.3 * rnorm(100)

for (index in 10 * 1:9){
    e1 = err[(index - 9):index]
    e2 = err[(index + 1):(index + 10)]
    print(cor(e1, e2))
}

x = runif(100)
y = 5 + 3 * x + err

mod = lm(y ~ x)

plot(x, y)
abline(mod)

