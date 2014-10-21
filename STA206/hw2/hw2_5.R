library(Matrix)

# 5a
############################################################
X = matrix(c(rep(1, 5),
             -0.63, 0.18, -0.84, 1.60, 0.33,
             -0.82, 0.49, 0.74, 0.58, -0.31), ncol=3)
Y = c(-0.97, 2.51, -0.19, 6.53, 1.00)
X
Y

# 5b
############################################################
XtX = t(X) %*% X
XtX
XtY = t(X) %*% Y
XtY
XtX_inverse = solve(XtX)
XtX_inverse 

# 5c
############################################################
beta = XtX_inverse %*% t(X) %*% Y
beta

# 5d
############################################################
H = X %*% XtX_inverse %*% t(X)
rankMatrix(H)[1]
I = diag(5)
rankMatrix(I - H)[1]

# 5e
############################################################
Yhat = X %*% beta
Yhat
residuals = Y - Yhat
residuals
SSE = sum((Y - Yhat) ** 2)
SSE
df_SSE = nrow(X) - ncol(X)
MSE = SSE / (df_SSE)
MSE
df_SSE

# 5f
############################################################
# Variance / Covariance matrix s^2{beta}
s2beta = MSE * XtX_inverse
s2beta
# Standard errors for b0, b1, b2 are
sqrt(diag(s2beta))
# Estimated covariance between b1 and b2 is
s2beta[2, 3]

# 5g
############################################################
# Estimated variance for residual of first case:
MSE * (I - H)[1, 1]

# 5h
############################################################
# Model equations



# 5i
############################################################
# Add interaction term between X1 and X2
X = cbind(X, X[, 2] * X[, 3])
X
# New hat matrix
H = X %*% solve(t(X) %*% X) %*% t(X)
rankMatrix(H)[1]
rankMatrix(I - H)[1]
# The ranks have changed to account for the additional column.

# 5j
############################################################
beta = solve(t(X) %*% X) %*% t(X) %*% Y
beta

# 5e
############################################################
Yhat = X %*% beta
Yhat
residuals = Y - Yhat
residuals
SSE2 = sum((Y - Yhat) ** 2)
SSE2
df_SSE2 = nrow(X) - ncol(X)
MSE = SSE2 / (df_SSE2)
MSE
df_SSE2

# 5l
############################################################
# Which model fits the data better?
# We calculate R^2
SSTO = sum((Y - mean(Y)) ** 2)
r2 = function(SSE) 1 - SSE / SSTO
# First model
r2(SSE)
# Second model
r2(SSE2)
# Adding terms to a fixed linear model generally increases the fit.
# It doesn't matter if the terms are noise or not.
