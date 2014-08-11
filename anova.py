'''
anova.py

Learning what anova does
'''

import math

import numpy as np
import statsmodels.stats.anova as anova
from scipy.stats import t
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

# TODO - plot the gamma function

# t (Student) distribution
#t1 = 

# Generalizes the t-test
