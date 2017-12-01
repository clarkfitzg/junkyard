n = 1e3L

X = matrix(rnorm(n*n), nrow = n)

library(microbenchmark)

fft(X)
