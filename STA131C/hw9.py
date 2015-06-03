import numpy as np
import pandas as pd
from scipy import stats
from statsmodels.formula.api import ols


print('11.2.8')

drugs = pd.DataFrame({
    'x': [1.9, 0.8, 1.1, 0.1, -0.1, 4.4, 4.6, 1.6, 5.5, 3.4],
    'y': [0.7, -1, -0.2, -1.2, -0.1, 3.4, 0, 0.8, 3.7, 2]})

fit = ols('y ~ x', drugs).fit()

b0, b1 = fit.params

sigma2 = fit.mse_resid
xbar = drugs.x.mean()
sx2 = sum((drugs.x - drugs.x.mean()) **2)
n = len(drugs)

varb0 = sigma2 * (1/n + xbar ** 2 / sx2)
varb1 = sigma2 / sx2
covb0b1 = -xbar * sigma2 / sx2

seb0 = np.sqrt(varb0)
seb1 = np.sqrt(varb1)

# Variance covariance matrix of beta coefficients
# Matches calculated ones above
fit.cov_params()

print('unbiased estimator of theta: ', 3 * b0 - 2 * b1 + 5)
print('MSE: ', (9 * varb0 + 4 * varb1 - 12 * covb0b1) / sigma2)

print('11.2.9')

c1 = -3 * covb0b1 / varb1
print(c1)

print('11.2.11')

print(xbar)

print('11.2.15')

x = np.linspace(0.5, 4, num=8)

print(-x.mean())

print('11.3.1')

df = pd.DataFrame({
    'x': [0.3, 1.4, 1, -0.3, -0.2, 1.0, 2.0, -1.0, -0.7, 0.7],
    'y': [0.4, 0.9, 0.4, -0.3, 0.3, 0.8, 0.7, -0.4, -0.2, 0.7]
    })

n = len(df)

fit = ols('y ~ x', df).fit()

b0, b1 = fit.params

# Sanity check- this should equal b0
np.dot(df.y - df.y.mean(), df.x - df.x.mean()) / sum((df.x -
    df.x.mean()) ** 2)

sigma = np.sqrt(fit.mse_resid)
xbar = df.x.mean()
sx2 = sum((df.x - df.x.mean()) **2)

# Should equal sigma
np.sqrt(sum(fit.resid ** 2) / (n - 2))

U0 = (b0 - 0.7) / (sigma * np.sqrt(1/n + xbar ** 2 / sx2))
print(U0)

t8 = stats.t(n - 2)
print('critical value', t8.ppf(1 - 0.05 / 2))

print('11.3.5')

c0 = 1
c1 = -5
U_01 = (c0**2 / n + (c0*xbar - c1)**2 / sx2) ** (-0.5) * (c0*b0 + c1*b1) / sigma
print(U_01)
print('critical value', t8.ppf(1 - 0.1 / 2))

print('11.3.10')

w = sigma * (1/n + xbar**2 / sx2) ** 0.5 * t8.ppf(1 - 0.05 / 2)

# should match
fit.conf_int(alpha=0.05).loc['Intercept']

print('0.95 confidence interval', b0 - w, b0 + w)

print('11.3.20')

n = 32
b0 = 68.17
b1 = -1.112
sigma = 4.281
xbar = 30.91
sx2 = 2054.8
alpha = 0.05

x = 24
y = b0 + b1 * x
print('prediction: ', y)

w = stats.t.ppf(1 - alpha/2, n - 2) * sigma * (1 + 1/n + (x - xbar)**2 /
        sx2) ** 0.5

print('interval: ', y - w, y + w)
