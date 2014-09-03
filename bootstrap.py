'''
Implement statistical bootstrap using a generator.

It would make sense to build a class around this, but it's probably better
to just use sklearn.
'''

import numpy as np
from numpy.random import choice, randn


def bootstrap(stat, data, n, lazy=False):
    '''
    bootstrap stat on data n times
    '''
    size = len(data)
    bootsamples = (choice(data, size) for i in range(n))
    stats = map(stat, bootsamples)

    if lazy:
        return stats
    else:
        return np.array(list(stats))


if __name__ == '__main__':

    lazy_means = bootstrap(np.mean, randn(1000), int(1e4), lazy=True)
    means = bootstrap(np.mean, randn(1000), int(1e2))
