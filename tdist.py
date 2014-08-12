'''
tdist.py

Plot the t distribution in the following forms:
    * Using scipy.stats.t
    * As derived from the normal distribution

Also, what do values of the t-test look like?
'''

import numpy as np
from matplotlib import pyplot as plt
from scipy.stats import t, ttest_1samp



def plot_cont(rv, n=100, left=-3, right=3):
    '''
    Plot a continuous probability distribution.
    The line is the probability density function, the histogram is a
    realization with n samples.

    Parameters
    ----------
    rv : frozen continuous random variable from scipy.stats
    n  : number of samples
    left, right : bounds of plot
    
    '''
    samps = rv.rvs(n)
    plt.hist(samps, normed=True, histtype='stepfilled', alpha=0.2)

    # Plot pdf only where samples were realized
    x = np.linspace(min(samps), max(samps))
    y = rv.pdf(x)

    plt.plot(x, y)
    plt.title('t distribution')
    plt.show()


rv = t(10)
plot_cont(rv)



norm = np.random.randn(100, 3)
norm_ttest = ttest_1samp(norm, 0)



# Check the t-test 
# t (Student) distribution
#t1 = 

# Generalizes the t-test
