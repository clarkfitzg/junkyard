'''
Chapter 9, Exercise 2 on page 146 of Wasserman's All of Statistics

Maximum likelihood estimators for parameters of uniform distribution.
Solving numerically as a constrained optimization problem.

Amazing what a difference it makes to use the log of the objective
function rather than the actual objective function.
'''

import numpy as np
from scipy import stats
from scipy.optimize import minimize, root


np.random.seed(89)

# True parameters
a, b = -10, 10

# Simulated data
n = 20
X = stats.uniform(a, b - a).rvs(n)
minX, maxX = min(X), max(X)
meanX, sdX = np.mean(X), np.std(X)


def obj(x):
    '''
    objective function to minimize, taking array as input
    '''
    a, b = x
    return -(b - a) ** (-n)


def log_obj(x):
    '''
    logarithm of objective function with constants dropped
    '''
    a, b = x
    return -np.log(1 / (b - a))


# Initializing with actual values
min_out = minimize(log_obj, (a, b),
                   #tol=1e-100,
                   #method='L-BFGS-B',
                   #method='SLSQP',
                   bounds=((None, minX), (maxX, None)))

if all(min_out.x == (minX, maxX)):
    print('Numerical optimization of MLE matched theoretical result exactly.')


############################################################
#
# Method of moments
# Numerically solve a system of nonlinear equations
#
# This doesn't work well at all here. Why do this over MLE?
#
############################################################

# Theoretical results
mm_a = meanX - np.sqrt(meanX ** 2 + 3 * sdX - meanX)
mm_b = 2 * meanX - mm_a


def f(x):
    '''
    Defines nonlinear system of equations
    '''
    a, b = x
    return [(a + b) / 2 - meanX,
            (b - a) ** 2 - 12 * sdX]

root_out = root(f, [a, b])

message = '''
True a and b values: {}, {}
Theoretical a, b from method of moments: {}, {}
Numerical a, b from method of moments: {}, {}

The theoretical and numerical should be very close.
If they aren't it's because my math is wrong.
'''.format(a, b, mm_a, mm_b, *root_out.x)

print(message)
