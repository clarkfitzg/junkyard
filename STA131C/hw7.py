import numpy as np
from scipy import stats


print('9.6.2')

# Checked numbers
A = [1.23, 1.42, 1.41, 1.62, 1.55, 1.51, 1.6, 1.76]
meanA = np.mean(A)
m = len(A)

B = [1.76, 1.41, 1.87, 1.49, 1.67, 1.81]
meanB = np.mean(B)
n = len(B)

SSA = sum((x - meanA)**2 for x in A)
SSB = sum((x - meanB)**2 for x in B)

U = np.sqrt(m + n - 2) * (meanA - meanB)
U = U / (np.sqrt(1/m + 1/n) * np.sqrt(SSA + SSB))

alpha = 0.1

critval = -stats.t(m + n - 2).ppf(1 - alpha)

print('Reject if {:.4g} < {:.4g}'.format(U, critval))

# Much better to use the builtin test:
stats.ttest_ind(A, B)


print('9.6.5')

k = 6 / 5

U = np.sqrt(m + n - 2) * (meanA - meanB)
U = U / (np.sqrt(1/m + k/n) * np.sqrt(SSA + SSB/k))

print('Reject if {:.4g} < {:.4g}'.format(U, critval))
