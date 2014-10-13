'''
Finally got Numba to work. And it's incredible. I'm a believer.
'''

import operator
import math
import random

from numba import jit
import numpy as np


n = int(1e2)
x = np.array([random.random() for i in range(n)])
y = np.array(list(range(n)))


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


@jit
def dot3(x, y):
    '''
    Loop style dot product
    '''
    product = 0
    n = len(x)
    for i in range(n):
        product += x[i] * y[i]
    return product


#numbadot = jit(dot2)
print(pydot(x, y))
print(dot2(x, y))
print(dot3(x, y))
