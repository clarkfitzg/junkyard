'''
datastream

Compute statistics on streaming data

Idea- maybe have light and heavy versions?
'''

from collections import deque
import random

import numpy as np
import statsmodels.api as sm


class LinearModel(deque):
    '''
    LinearModel is an ordinary least squares linear regression.

    Parameters
    ----------
    maxlen : int
        The number of observations (rows) to keep in memory

    '''

    def __init__(self, maxlen):
        super().__init__(maxlen=maxlen)
        self.fitted = False

    def __repr__(self):
        return 'LinearModel(maxlen={})'.format(self.maxlen)


if __name__ == '__main__':
    lm = LinearModel(10)
    a = deque([(1, 2), (3, 4)], maxlen=3)
    n = int(1e3)
    # interesting- summing this deque is much faster than the 
    # Numpy array of the same size
    d = deque((random.random() for i in range(n)), maxlen=n)
    dnp = np.array(d)
