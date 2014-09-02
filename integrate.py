'''
Testing out numerical integration schemes
'''

import numpy as np
from scipy.stats import norm
from scipy.integrate import quad

def f(x):
    return (1/3) * x ** (-2/3)

def id(x):
    return x

results = {}
results['f'] = quad(f, 0, 1)
results['id'] = quad(id, 0, 1)
results['norm'] = quad(norm.pdf, -np.infty, np.infty)

# TODO - try multivariate function
def f(x, y):
    pass
