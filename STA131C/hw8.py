import pandas as pd
import numpy as np
from scipy import stats
import statsmodels.formula.api as smf
import matplotlib.pyplot as plt


print('9.7.7')


def varmle(sumx, sumx2, n):
    '''
    Compute MLE for variance 

    sumx:   sum of x
    sumx2:  sum of x^2
    n:      sample size n

    '''
    return (sumx2 - sumx ** 2 / n) / n


nx = 16
ny = 10
varx_mle = varmle(84, 563, nx)
vary_mle = varmle(18, 72, ny)

print('MLE for variance of X: {:.4g}'.format(varx_mle))
print('MLE for variance of Y: {:.4g}'.format(vary_mle))

# Eq 9.7.4
V = (varx_mle * nx / (nx - 1)) / (vary_mle * ny / (ny - 1))

alpha = 0.05

f = stats.f(nx - 1, ny - 1)
pvalue = f.sf(V)
critval = f.ppf(1 - alpha)

print('Reject if {} > {}'.format(V, critval))

print('\n9.7.8')

critvals = {'c1': f.ppf(alpha / 2), 'c2': f.ppf(1 - alpha / 2)}

print(critvals)

print('\n11.1.7')

x = np.linspace(0.5, 4, num=8)
y = 40 + np.array([0, 1, 3, 2, 4, 2, 3, 2])

df = pd.DataFrame({'x': x, 'y': y})

fit1 = smf.ols('y ~ x', df).fit()
print(fit1.params)

fit2 = smf.ols('y ~ x + I(x ** 2)', df).fit()
print(fit2.params)

plt.scatter(df['x'], df['y'])

# Predict on new points for a smooth plot
x1, xn = min(df['x']), max(df['x'])
xpts = pd.DataFrame({'x': np.linspace(x1, xn)})

plt.plot(xpts, fit1.predict(xpts))
plt.plot(xpts, fit2.predict(xpts))

plt.xlabel('x')
plt.ylabel('y')

plt.savefig('11_1_7.pdf')
