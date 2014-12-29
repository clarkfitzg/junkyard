'''
What is the best way to write nested loops?
Should be based on the layout in memory

Interesting- jit doesn't take the default arguments.

These times demonstrate that Numpy arrays are indeed laid out in row major
order. "The rightmost index varies the fastest"
'''

import numpy as np
from numba import jit


x = np.random.randn(1000, 1000)


@jit
def rowinside(x=x):
    '''
    The inner loop is over the rows for an n x m array
    435 ms without jit
    2.13 ms with jit
    '''
    total = 0
    n, m = x.shape
    for i in range(n):
        for j in range(m):
            total += x[i, j]
    return total


@jit
def colinside(x=x):
    '''
    The inner loop is over the columns for an n x m array
    447 ms without jit
    7.22 ms with jit
    '''
    total = 0
    n, m = x.shape
    for j in range(m):
        for i in range(n):
            total += x[i, j]
    return total
