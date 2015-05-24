from scipy import stats

print('9.7.7')

def varmle(sumx, sumx2, n):
    '''
    Compute MLE for variance 

    sumx:   sum of x
    sumx2:  sum of x^2
    n:      sample size n

    '''
    xbar = sumx / n
    return (sumx2 - 2 * xbar * sumx + n * xbar ** 2) / 16

nx = 16
ny = 10
varx_mle = varmle(84, 563, nx)
vary_mle = varmle(18, 72, ny)

print('MLE for variance of X: {:.4g}'.format(varx_mle))
print('MLE for variance of Y: {:.4g}'.format(vary_mle))

# Eq 9.7.4
V = (varx_mle * nx / (nx - 1)) / (vary_mle * ny / (ny - 1))

pvalue = stats.f.sf(V, nx - 1, ny - 1)

print(pvalue)

print('11.1.7')

x = np.linspace(0.5, 4, num=8)
y = 40 + np.array([0, 1, 3, 2, 4, 2, 3, 2])
