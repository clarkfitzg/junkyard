'''
Working on problem 7.6.15 in Degroot and Schervish book
'''

import numpy as np
from numpy import log
from scipy.optimize import minimize


def llhood(mu):
    beta = 1 / mu
    l = 20 * log(beta) - 135 * beta
    return -l


out = minimize(llhood, 6.5)

print(out['x'])


x = np.linspace(5, 8)
y = llhood(x)
