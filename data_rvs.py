'''
examples for blog post `data as random variables`
'''

import numpy as np
from scipy import stats


np.random.seed(37)


def rv_discrete_factory(a):
    '''
    Creates a discrete random variable from scipy.stats

    >>> rv = rv_discrete_factory((0, 0.5, 0.5, 1))
    >>> rv.cdf(0.9)
    0.75

    '''
    vals, counts = np.unique(a, return_counts=True)
    probs = counts / sum(counts)
    return stats.rv_discrete(values=(vals, probs))


data = np.random.choice((3.14, 10, 37), size=10)
print(data)

rv = rv_discrete_factory(data)


if __name__ == '__main__':
    import doctest
    doctest.testmod()
