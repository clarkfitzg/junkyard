'''
bootstrap.py

Defines a class implementing a scalar statistical bootstrap.

Author: Clark Fitzgerald
License: BSD 3-clause
'''

from __future__ import division
import functools

import numpy as np
from scipy import stats


class bootstrap(object):
    '''
    Implements bootstrap by calling a statistical function on
    a sample of the same size as the data with replacement.

    Parameters
    ----------
    data : ndarray
        sample data
    stat : callable
        function to call on data
    reps : int
        Number of repetitions
    lazy : boolean
        If lazy = True then this object is an iterator, returning the
        statistic called on a new sample each time.

    Attributes
    ----------
    actual : numeric
        The actual value of the statistic called on the data
    results : ndarray
        array with shape (reps, 1) holding results of bootstrapped
        statistic
    stderror : numeric
        The sample standard error of the bootstrapped statistic.
        This is the standard deviation of `results` attribute.

    Methods
    -------
    confidence(percent, method='percentile')
        Confidence interval for the statistic
    waldtest(hypothesis)
        Computes Wald test that statistic is near hypothesis
    pvalue(hypothesis)
        Computes p-value 

    References
    ----------
    Wasserman, All of Statistics, 2005
    '''

    def __init__(self, data, stat=np.mean, reps=1000, lazy=False):
        self.data = data
        self.samplesize = len(data)
        self.stat = stat
        self.reps = reps
        self._reps_remain = reps
        self.actual = stat(data)
        self.lazy = lazy
        if not lazy:
            self._run()

    def __repr__(self):
        return ''.join(['bootstrap(data, stat=', self.stat.__name__, ', reps=',
                        str(self.reps), ', lazy=', str(self.lazy), ')'])

    def __iter__(self):
        return self

    def __next__(self):
        if self._reps_remain <= 0:
            raise StopIteration
        else:
            # Decrement and return statistic applied to bootstrap sample
            self._reps_remain -= 1
            bootsample = np.random.choice(self.data, self.samplesize)
            return self.stat(bootsample)

    def __len__(self):
        return self.reps

    def _run(self):
        '''
        Run the bootstrap simulation.

        If lazy = False (the default) then this will run on instantiation,
        creating the results arribute.
        '''
        self.results = np.array([stat for stat in self])
        self.stderror = np.std(self.results)

    def _notlazy(func):
        '''
        Decorator to raise AttributeError with informative error message in
        case users try to use code which is not lazy.
        '''
        @functools.wraps(func)
        def wrapper(*args, **kwargs):
            try:
                return func(*args, **kwargs)
            except AttributeError:
                raise AttributeError("{} is not available. Try using bootstrap"
                                     " with lazy=False.".format(func.__name__))
        return wrapper

    @_notlazy
    def waldtest(self, hypothesis):
        '''
        Computes the Wald test as compared to the normal distribution:

        W = (actual - hypothesis) / stderror

        where actual is the value of the observed statistic.

        Parameters
        ----------
        hypothesis : float
            statistical parameter that's being tested against

        Returns
        -------
        W : float
            Wald test statistic

        http://en.wikipedia.org/wiki/Wald_test
        '''
        return (self.actual - hypothesis) / self.stderror

    @_notlazy
    def pvalue(self, hypothesis):
        '''
        Computes the p-value that the observed statistic is the same as
        the hypothesis.

        Parameters
        ----------
        hypothesis : float
            statistical parameter that's being tested against

        Returns
        -------
        p-value : float

        Notes
        -----
        This assumes that the statistic is normally distributed.

        A commonly used evidence scale:

        p-value         evidence
        ============================================================
        < 0.01          very strong evidence against hypothesis
        0.01 - 0.05     strong evidence against hypothesis
        0.05 - 0.1      weak evidence against hypothesis
        > 0.1           little to no evidence against hypothesis

        Source : Wasserman, 2005, All of Statistics
        '''
        W = abs(self.waldtest(hypothesis))
        return 2 * stats.norm.sf(W)

    @_notlazy
    def confidence(self, percent=95, method='percentile'):
        '''
        Compute a confidence interval.

        Parameters
        ----------
        percent : numeric
            Number between 0 and 100 indicating desired size of interval
        method : string
            'percentile' : Uses percentile function applied to empirical
                distribution of results.
            'normal' : assumes that the distribution of the bootstrapped
                statistic is normal.
            'pivotal' : Not yet implemented

        Returns
        -------
        lower, upper : ndarray of float
            lower and upper bounds for the confidence interval

        See Also
        --------
        stats.<distribution>.interval : Compute exact interval around median
        when distribution is known.

        Examples
        --------
        >>> np.random.seed(321)
        >>> b = bootstrap(np.random.randn(100), stat=np.mean, reps=100)

        Higher confidence generally implies larger intervals.

        >>> b.confidence(50)
        array([-0.10479162,  0.02798614])
        >>> b.confidence(99)
        array([-0.25964484,  0.2575893 ])

        Different methods will produce different results.

        >>> b.confidence(99, method='normal')
        array([-0.29159177,  0.2225721 ])

        '''

        allmethods = {'percentile', 'normal'}

        if method not in allmethods:
            raise NotImplementedError('{} is not an available method for'
                                      ' confidence intervals. Try one of'
                                      ' {}.'.format(method, allmethods))

        if method == 'percentile':
            diff = (100 - percent) / 2
            return np.percentile(self.results, [diff, 100 - diff])

        elif method == 'normal':
            alpha = percent / 100
            normdist = stats.norm(self.actual, self.stderror)
            return np.array(normdist.interval(alpha))


if __name__ == '__main__':

    np.random.seed(10)
    b = bootstrap(np.random.randn(100))
