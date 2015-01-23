from scipy.stats import binom

n = 8
X

a = binom(n, 0.1).pmf(X)
b = binom(n, 0.2).pmf(X)

print(a / (a + b))
