'''
Testing out numerical integration schemes
'''

import numpy as np
from scipy.stats import norm
from scipy.integrate import quad, dblquad, nquad

def f(x):
    return (1/3) * x ** (-2/3)

def id(x):
    return x

def multi(y, x):
    return 4 * x * y

def doublex(x, y):
    return 2 * x + y

results = {}
results['f'] = quad(f, 0, 1)
results['id'] = quad(id, 0, 1)
results['norm'] = quad(norm.pdf, -np.infty, np.infty)
# not too impressed with this dblquad making y the first arg
results['multi'] = dblquad(multi, 0, 1, lambda x: 0, lambda x: 1-x)
results['doublex'] = nquad(doublex, ((0, 1), (0, 2)))
