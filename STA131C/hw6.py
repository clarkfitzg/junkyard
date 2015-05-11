import numpy as np
from scipy import stats, optimize


print('9.4.1')

Z = stats.norm()
print(Z.ppf(0.05))

print('9.4.4')

n = 25

def power(mu, c):
    return Z.cdf(np.sqrt(n) * (c[0] - mu)) + 1 - Z.cdf(np.sqrt(n) * (c[1] - mu))

def f(c):
    return power(0.1, c) - 0.07, power(0.2, c) - 0.07

ans = optimize.root(f, (0, 0.3))

print(ans.x)

print('9.4.12')

print(stats.expon().ppf((0.05, 0.95)))

print('9.5.1')

u = np.sqrt(10) * (1.379 - 1.2) / 0.3277

T = stats.t(9)

print('Reject if {} > {}'.format(u, T.ppf(1-0.05)))

print('pvalue', 1 - T.cdf(u))

print('9.5.4')

sigma = np.sqrt((43.7 + 2*1.4*11.2 + 8 * 1.4**2) / 7)

tstar = np.sqrt(8) * 1.4 / sigma

cval = stats.t(7).ppf(1 - 0.1 / 2)

print('Reject if {} > {}'.format(tstar, cval))

print('Reject if 1.1 not in', stats.t(9).ppf((0.01, 1-0.09)))
