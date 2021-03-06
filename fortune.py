import numpy as np
from scipy.stats import binom
from scipy.special import comb
from trix import replicate


n_plays = 50
n_samples = int(1e4)


def fortune(wins):
    '''
    fortune after wins
    '''
    return 2 ** wins * (0.5) ** (n_plays - wins)


def experiment():
    wins = binom(n_plays, 0.5).rvs(n_samples)
    outcomes = fortune(wins)
    return np.mean(outcomes)


results = replicate(experiment, 100)

expected = sum(0.5 ** (2*k) * comb(n_plays, k) for k in range(n_plays))
