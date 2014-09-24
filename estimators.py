'''
Exercise 2 on page 95 of Wasserman's all of Statistics
'''

from pprint import pprint

import numpy as np
from scipy.stats import uniform

from trix import replicate


np.random.seed(7931)
n = 10
theta = 1
num_experiments = 1000


def theta_hat(n=n, theta=theta):
    '''
    Calculate theta_hat
    '''
    x = uniform(0, theta).rvs(n)
    return max(x)


def theory_ex(n=n, theta=theta):
    '''
    theoretical expectation of theta_hat
    '''
    return n * theta / (n + 1)


def theory_se(n=n, theta=theta):
    '''
    theoretical standard error of theta_hat
    '''
    return theta * np.sqrt(n / (n + 2) - (n/(n+1))**2)


hats = replicate(theta_hat, num_experiments)

# TODO Formalize this using hypothesis testing.
results = {'theta': theta,
           'theory_se': theory_se(),
           'theory_ex': theory_ex(),
           'sample_se': np.std(hats),
           'sample_ex': np.mean(hats),
           }

pprint(results)
