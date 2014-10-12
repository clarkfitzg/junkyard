'''
Some timings for linear regression fitting
'''

import operator
import math

import numpy as np
from scipy import stats
from collections import deque


np.random.seed(14)

n = 100

x = np.random.uniform(size=n)
y = 10 + 4 * x + np.random.randn(n)

# For pure Python
xlist, ylist = map(list, (x, y))
xdeque, ydeque = map(deque, (x, y))

# numpy least squares needs the dummy variable
A = np.vstack([x, np.ones(len(x))]).T


# How about a homegrown least squares?
def lm_numpy(x, y):
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


# Version in pure Python

def dot(x, y):
    '''
    The dot product of x and y
    '''
    return math.fsum(map(operator.mul, x, y))


def mean(x):
    '''
    The mean of x
    '''
    return math.fsum(x) / len(x)


def lm_pure(x, y):
    '''
    Fit least squares to x, y Python lists
    '''
    xbar = mean(x)
    ybar = mean(y)
    
    xcentered = [x_i - xbar for x_i in x]
    ycentered = [y_i - ybar for y_i in y]

    b1 = dot(xcentered, y) / dot(xcentered, xcentered)
    b0 = ybar - b1 * xbar

    return b0, b1


# Numpy one is twice as fast
least_squares = {'numpy': np.linalg.lstsq(A, y),    # 149 us
                 'scipy': stats.linregress(x, y),   # 333 us
                 'homegrown': lm_numpy(x, y),       # 56  us
                 'pure_py': lm_pure(xlist, ylist),  # 117 us
                 'deque': lm_pure(xdeque, ydeque),  # 119 us
                 }
