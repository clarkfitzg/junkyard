# 4a

X = matrix(c(rep(1, 5), 1.86, 0.22, 3.55, 3.29, 1.25), ncol=2)

Y = c(1.41, 0.68, 2.89, 3.19, 3.11)

# 4b
XtX = t(X) %*% X

# 4c

XtX_inverse = solve(XtX)

# 4d
beta = XtX_inverse %*% t(X) %*% Y

print(as.list(.GlobalEnv))
