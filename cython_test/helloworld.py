'''
Finally got Numba to work. And it's incredible. I'm a believer.
'''

import operator
import math
import random

from numba import jit
import numpy as np


n = int(1e2)
x = np.random.randn(n)
y = np.random.randn(n)


#@jit
def pydot(x, y):
    '''
    dot product in Python
    '''
    return sum(map(operator.mul, x, y))


@jit
def dot2(x, y):
    '''
    Loop style dot product
    '''
    product = 0
    for xi, yi in zip(x, y):
        product += xi * yi
    return product


# Seems to work about the same with or without the signature
#@jit(nopython=True)
#@jit('f8(f8[:],f8[:])')
@jit
def dot3(x, y):
    '''
    Loop style dot product
    '''
    for i in range(4000):
        product = 0
        n = len(x)
        for i in range(n):
            product += x[i] * y[i]
    return product

xl, yl = map(list, (x, y))


# Slow, but had to try
@jit
def getit(x, n):
    return x[n]


print(pydot(x, y))
print(dot2(x, y))
print(dot3(x, y))
