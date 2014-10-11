'''
Some timings for linear regression fitting
'''

import numpy as np
from scipy import stats


np.random.seed(14)

n = 100

x = np.random.uniform(size=n)
y = 10 + 4 * x + np.random.randn(n)

# numpy least squares needs the dummy variable
A = np.vstack([x, np.ones(len(x))]).T

# How about a homegrown least squares?
def lm(x, y):
    '''
    Fit least squares to x, y numpy arrays
    '''
    xbar = x.mean()
    ybar = y.mean()
    
    xcentered = x - xbar
    ycentered = y - ybar

    b1 = xcentered.dot(y) / xcentered.dot(xcentered)
    b0 = ybar - b1 * xbar

    return b0, b1


# Numpy one is twice as fast
least_squares = {'numpy': np.linalg.lstsq(A, y),    # 149 us
                 'scipy': stats.linregress(x, y),   # 333 us
                 'homegrown': lm(x, y),             # 55.9 us
                 }

# TODO write one that uses lists or deques rather than numpy arrays

xlist, ylist = map(list, (x, y))
