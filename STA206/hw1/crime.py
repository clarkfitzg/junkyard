'''
HW 1
'''

import numpy as np
from scipy import stats

# Question 8

# Provided data
n = 84
sum_x = 6602
sum_y = 597341
sum_x2 = 522098
sum_y2 = 4796548849
sum_xy = 46400230

# Calculations
mean_x = sum_x / n
mean_y = sum_y / n

# 8a
sxx = sum_x2 - n * mean_x ** 2
b1 = (sum_xy - mean_x * sum_y) / sxx
b0 = mean_y - b1 * mean_x
print('b0 and b1 are : ', b0, b1)

# 8b
ssto = sum_y2 + n * mean_y ** 2
sse = ssto + (b1 ** 2) * sxx
mse = sse / (n - 2)
print('sse and mse are : ', sse, mse)

# 8c
var_y = ssto / (n - 1)
sd_y = np.sqrt(var_y)

sd_b0 = var_y * (1/n + mean_x ** 2 / sxx)
sd_b1 = var_y / sxx
print('standard errors for b0 and b1 are : ', sd_b0, sd_b1)

# 8d
nulldist = stats.t(n - 2)
alpha = 0.01
t_interval = nulldist.ppf((alpha / 2, 1 - alpha / 2))
stat_8d = b1 / sd_b1
print('Reject h0 if {} is not in the interval {}'.format(stat_8d,
      t_interval))

# 8e
b0_confidence = t_interval * sd_b0
print('A 99% confidence interval for b0 is ', b0_confidence)

# 8f
alpha2 = 0.05 / 2
mse_confidence = mse * stats.chi2(n - 2).ppf((alpha2, 1 - alpha2))
print('A 95% confidence interval for sigma squared is ', mse_confidence)
