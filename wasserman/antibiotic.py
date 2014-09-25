'''
Ch. 7 Exercise 9 on p. 105 of Wasserman's text.
'''

import numpy as np
from scipy.stats import norm


p1, p2 = 0.9, 0.85
n = 100

sigma_x = np.sqrt(p1 * (1 - p1) / n)
sigma_y = np.sqrt(p2 * (1 - p2) / n)

theta_hat = p1 - p2
se = sigma_x + sigma_y


def norm_confidence(mu, se, percent):
    '''
    Normal based confidence interval

    Parameters
    ----------
    mu : numeric
        mean value of statistic
    se : numeric
        standard error, the standard deviation of the statistic
    percent : numeric
        Width of confidence interval between 0 and 100

    Examples
    --------
    >>> confidence(0.05, 0.065707142142714253, 80)
    array([-0.03420709,  0.13420709])

    '''
    start = (1 - percent / 100) / 2
    rv = norm(mu, se)
    return rv.ppf((start, 1 - start))


levels = (50, 80, 95, 99)
conf = {level: confidence(theta_hat, se, level) for level in levels}


if __name__ == '__main__':
    import doctest
    doctest.testmod()
