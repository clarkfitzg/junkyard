'''
Working on problem 7.6.15 in Degroot and Schervish book

This isn't working at all.
'''

import numpy as np
from scipy.optimize import minimize


def obj(beta):
    gamma120 = beta ** 120 * np.exp(-120 * beta)
    expcdf15 = 1 - np.exp(15 * beta)
    return -(gamma120 * expcdf15)


out = minimize(obj, 1/6)

ans = 1 / out['x']
print(ans)

x = np.linspace(5, 8)
y = obj(x)
