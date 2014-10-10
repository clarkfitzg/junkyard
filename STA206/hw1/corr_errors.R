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

# We can express b1 as a fraction of inner products of centered vectors
x_c = x - mean(x)
y_c = y - mean(y)
b1 = (x_c %*% y_c) / (x_c %*% x_c)
b1_pg3 = (x_c %*% y) / (x_c %*% x_c)

mod = lm(y ~ x)

plot(x, y)
abline(mod)

