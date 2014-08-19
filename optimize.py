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
    return np.sqrt(sum(vec ** 2))


x0 = np.ones(5)

m_norm = minimize(norm, 1)
m_l2 = minimize(l2, x0)

def pointy(x):
    '''
    A pointier objective function. Maybe easier to minimize?
    '''
    return np.abs(x) ** 0.1

# Not working
m_pointy = minimize(pointy, 1)
