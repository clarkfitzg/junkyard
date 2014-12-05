'''
PMF (probability mass function) for a multinomial distribution
'''

from functools import reduce, partial
from operator import mul
from scipy.special import factorial as f
from scipy.stats import binom


def multipmf(n, p, k):
    '''
    n : total number of choices
    p : sequence of probabilities
    k : sequence of values
    '''
    mcoef = f(n) / reduce(mul, (f(x) for x in k))
    probs = reduce(mul, (prob ** x for prob, x in zip(p, k)))
    return mcoef * probs


p = [0.5625, 0.375, 0.0625]
k = [8, 6, 1]

a = multipmf(15, p, k)
print(a)

b = binom(15, 0.375).pmf(6)
print(b)

c1 = binom(9, 0.5625 / (0.5625 + 0.0625)).pmf(8)
c2 = a / b
print(c1, c2)

# Question 2.10

p10 = [0.3125, 0.25, 0.4375]
print(multipmf(15, p10, (5, 4, 6)))

print(binom(15, 0.25).sf(2))
print(binom(15, 1 - 0.3125).cdf(5))

