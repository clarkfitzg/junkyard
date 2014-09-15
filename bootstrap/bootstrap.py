'''
Class for statistical bootstrap
'''

import numpy as np
from numpy.random import choice, randn


class bootstrap(object):
    '''
    Implements a statistical bootstrap

    Parameters
    ----------
    data : array_like
        Only np.ndarrays are currently supported
    statistic : callable
        function to call on data
    reps : int
        Number of repetitions

    '''

    def __init__(self, data, statistic=np.mean, reps=1000):
        self.data = data
        self.samplesize = len(data)
        self.statistic = statistic
        self.reps = reps

    def __iter__(self):
        return self

    def __next__(self):
        if self.reps <= 0:
            raise StopIteration
        else:
            # Decrement and return statistic applied to bootstrap sample
            self.reps -= 1
            return self.statistic(choice(self.data, self.samplesize))

    def __len__(self):
        return self.reps

    def confidence(n=1000):
        '''
        
        return a confidence interval 
        '''
        pass



def booty(self, lazy=False):
    '''
    bootstrap statistic on data n times
    '''
    size = len(data)
    bootsamples = (choice(data, size) for i in range(n))
    stats = map(statistic, bootsamples)

    if lazy:
        return stats
    else:
        return np.array(list(stats))



if __name__ == '__main__':

    np.random.seed(24)

    #lazy_means = bootstrap(np.mean, randn(1000), int(1e4), lazy=True)
    #means = bootstrap(np.mean, randn(1000), int(1e2))
