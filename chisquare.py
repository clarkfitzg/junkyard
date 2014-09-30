'''
The Chi squared test is used to test whether data comes from a
multinomial distribution
'''

import numpy as np
from scipy import stats


np.random.seed(32)

n = 100
pvals = np.array((0.1, 0.2, 0.7))
expected = n * pvals

true_multi = np.random.multinomial(n, pvals)

cstest = stats.chisquare(true_multi, expected)

def chi(data=true_multi, expected=expected):
    '''
    recomputing Pearson's chi2 test to make sure I understand
    '''
    return sum((data - expected) ** 2 / expected)


# yep, it's same
assert cstest[0] == chi()
