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


def plot_rv_cont(rv, nsamp=100, nruns=5):
    '''
    Plot probability distribution for a continous random variable.
    The line is the probability density function, the histograms are
    realizations with `nsamp` samples.

    Parameters
    ----------
    rv : frozen continuous random variable from scipy.stats
    nsamp  : number of samples for each run
    nruns  : number of times to draw nsamp and plot histogram
    
    '''
    # For shading
    alpha = 1.0 / nruns

    left = rv.median()
    right = rv.median()

    for i in range(nruns):
        samps = rv.rvs(nsamp)
        left = min(left, min(samps))
        right = max(right, max(samps))
        plt.hist(samps, normed=True, histtype='stepfilled', alpha=alpha, color='green')

    # Plot pdf only where samples were realized
    x = np.linspace(left, right, num=100)
    y = rv.pdf(x)
    plt.plot(x, y, linewidth=4)

    plt.title('{} distribution'.format(rv.dist.name))
    plt.show()
    
    return plt


rv = t(10)
a = plot_rv_cont(rv)
