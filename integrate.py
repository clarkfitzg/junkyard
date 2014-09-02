'''
Testing out numerical integration schemes
'''

import numpy as np
from scipy.stats import norm
from scipy.integrate import quad, dblquad

def f(x):
    return (1/3) * x ** (-2/3)

def id(x):
    return x

def multi(y, x):
    return x + y

results = {}
results['f'] = quad(f, 0, 1)
results['id'] = quad(id, 0, 1)
results['norm'] = quad(norm.pdf, -np.infty, np.infty)
results['multi'] = dblquad(multi, 0, 1, lambda x: 0, lambda x: 1)
