'''
Experimenting with Numpy's builtin linear regression capabilities
'''

import numpy as np
from numpy.linalg import lstsq
import statsmodels.api as sm
import pandas as pd
from sklearn.linear_model import LinearRegression


np.random.seed(100)

n = 1000
p = 5

x = np.random.randn(n, p - 1)

# add first column of ones
firstcolumn = np.ones(n).reshape(n, 1)
x = np.concatenate([firstcolumn, x], axis=1)

beta = np.array([5, 10, 20, -35, 100])
epsilon = np.random.randn(n)

y = x.dot(beta) + epsilon

betahat, rss, rank, singular = lstsq(x, y)

# Check some basic facts
yhat = x.dot(betahat)
e = y - yhat

# TODO - Make a function out of printing like this.

# The following should be numerically 0:
zeros = ['np.mean(yhat) - np.mean(y)', 'sum(e)', 'yhat.dot(e)']
for code in zeros:
    print('\n'.join(['---', code, str(eval(code))]))

smfit = sm.OLS(y, x).fit()
# This takes 1.04 millisecond compared to 262 microseconds for numpy lstsq

df = pd.DataFrame(x, index=y)
df.to_csv('simulated.csv', header=False)

# 508 microseconds
# Doesn't provide any of the stat stuff though...
skfit = LinearRegression().fit(x, y)

