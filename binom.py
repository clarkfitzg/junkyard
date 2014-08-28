'''
Stats in pure Python
'''

from functools import reduce
from operator import mul


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


if __name__ == '__main__':
    import doctest
    doctest.testmod()
