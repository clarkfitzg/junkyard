'''
pystats.py

Stats in pure Python
'''

import collections
from random import random
from functools import reduce, partial
from operator import mul


class weighcount(collections.Counter):
    '''
    Returns a subclass of collections.Counter that computes
    weights and totals

    >>> wc = weighcount({'a': 2, 'b': 8})
    >>> wc.total()
    10
    >>> wc.common_weights()
    [('b', 0.8), ('a', 0.2)]

    See also:
        collections.Counter
    '''

    def total(self):
        '''
        The sum of all counts
        '''
        return sum(self.values())

    def weight(self, key):
        '''
        Returns the weight associated with `key`.
        '''
        return self[key] / self.total()

    def gen_weights(self):
        '''
        Generator over (element, weight) tuples.
        Weight is recomputed for every element / iteration.
        '''
        for key in self:
            yield key, self.weight(key)

    def common_weights(self, n=None):
        '''
        List the n most common elements and their weights from the most
        common to the least.  If n is None, then list all element counts.

        >>> letters = weighcount({'a': 2, 'b': 8, 'c': 10})
        >>> letters.common_weights(2)
        [('c', 0.5), ('b', 0.4)]

        Analagous to `most_common` method for counts.
        '''
        common_values = (t[0] for t in self.most_common(n))
        return [(x, self.weight(x)) for x in common_values]


def factorial(n):
    '''
    Calculate n! = n * (n-1) * ... * 1

    >>> factorial(4)
    24

    '''
    return reduce(mul, range(1, n + 1))


def binom(n, k):
    '''
    Exact calculation of binomial coefficient n choose k

    >>> binom(5, 3)
    10

    '''
    if k < n - k:
        return binom(n, n - k)

    # Now calculate assuming k >= n-k
    numerator = reduce(mul, range(k + 1, n + 1))
    denominator = reduce(mul, range(1, n - k + 1))
    return numerator // denominator


def sample_iter(iterable, prob=0.5):
    '''
    Returns iterator which randomly samples elements from `iterator` with 
    probability `prob` that each element is yielded.

    >>> import random
    >>> random.seed(12)
    >>> squares = (x ** 2 for x in range(10))
    >>> list(sample_iter(squares, 0.1))  # Probability is 0.1
    [16]

    See Also:
        filter, random.sample, itertools.compress

    '''
    if not 0 <= prob <= 1:
        raise ValueError('Probability must be between 0 and 1')

    condition = lambda x: random() < prob
    return filter(condition, iterable)
