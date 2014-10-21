# 4a
X = matrix(c(rep(1, 5), 1.86, 0.22, 3.55, 3.29, 1.25), ncol=2)
Y = c(1.41, 0.68, 2.89, 3.19, 3.11)
X
Y

# 4b
XtX = t(X) %*% X
XtX
XtY = t(X) %*% Y
XtY

# 4c
XtX_inverse = solve(XtX)
XtX_inverse 

# 4d
beta = XtX_inverse %*% t(X) %*% Y
beta 
