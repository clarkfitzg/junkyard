'''
optimize.py

Exploring scipy.optimize.minimize
'''

import numpy as np
from numpy.linalg import norm
from scipy.optimize import minimize


def l2(vec):
    '''
    Compute l2 vector norm
    '''
    return np.sqrt(sum(abs(vec)))

x0 = np.ones(5)

# Why are these behaving differently?
m_norm = minimize(norm, 1)
m_l2 = minimize(l2, 1)
