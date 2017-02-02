b0 = 1
b1 = 5
sigma = 10
n = 10000L
set.seed(37)
x = runif(n)
epsilon = sigma * rt(n, 3)
y = b0 + b1 * x + epsilon
dyn.load("bootbetas.so")
beta = numeric(2)
true_beta = coef(lm(y ~ x))

#options(CBoundsCheck = TRUE)


#void fit_ols(double *x, double *y, int *n, double *beta)
out = .C("fit_ols", x, y, n, beta)

