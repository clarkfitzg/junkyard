'''
gamma.py

Learning what gamma function does
'''

import math

import numpy as np
from matplotlib import pyplot as plt
import statsmodels.stats.anova as anova
from scipy.stats import t, ttest_1samp
from scipy.optimize import minimize
from scipy.special import gamma
from scipy.misc import factorial

# understanding gamma function
x = np.arange(1, 10)

# We expect it to be close to this
ymf = np.array(map(math.factorial, x))[:-1]

ymg = np.array(map(math.gamma, x))[1:]
yf = factorial(x)[:-1]
yg = gamma(x)[1:]

# Shows that gamma function works as expected
for computed in [ymg, yf, yg]:
    assert np.allclose(computed, ymf)

def plot_gamma(left=0.2, right=4):
    '''
    plot the gamma function
    '''
    x = np.linspace(left, right)
    y = gamma(x)

    plt.plot(x, y)
    plt.title('gamma function')
    plt.show()

plot_gamma()

# It appears that the gamma function has a minimum around 1.5.
m = minimize(gamma, 1.5)
print('Minimum for the gamma function on the real line is at {}, '
      'with a value of {}'.format(m.x[0], m.fun))

norm = np.random.randn(100, 3)
norm_ttest = ttest_1samp(norm, 0)



# Check the t-test 
# t (Student) distribution
#t1 = 

# Generalizes the t-test
