'''
Implement bootstrap using generator
'''

import numpy as np
from numpy.random import choice, randn


def bootstrap(stat, data, n):
    '''
    lazily bootstrap stat on data n times
    '''
    size = len(data)
    bootsamples = (choice(data, size) for i in range(n))
    return map(stat, bootsamples)


means = bootstrap(np.mean, randn(1000), int(1e4))
