'''
HW 1
'''

from pprint import pprint

import pandas as pd
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
ssto = sum_y2 - n * mean_y ** 2
sse = ssto - (b1 ** 2) * sxx
mse = sse / (n - 2)
print('sse and mse are : ', sse, mse)

# 8c
var_b0 = mse * (1/n + mean_x ** 2 / sxx)
var_b1 = mse / sxx
sd_b0 = np.sqrt(var_b0)
sd_b1 = np.sqrt(var_b1)
print('standard errors for b0 and b1 are : ', sd_b0, sd_b1)

# 8d
t99 = np.array(stats.t(n - 2).interval(0.99))
stat_8d = b1 / sd_b1
print('Reject h0 if {} is not in the interval {}'.format(stat_8d,
      t99))

# 8e
b0_confidence = b0 + t99 * sd_b0
print('A 99% confidence interval for b0 is ', b0_confidence)

# 8f
chi95 = np.array(stats.chi2(n - 2).interval(0.95))
mse_confidence = sse / chi95
print('A 95% confidence interval for sigma squared is ', mse_confidence)

# 8g
x85 = 85
y85 = b0 + b1 * x85
var_y85 = mse * (1/n + (x85 - mean_x) ** 2 / sxx)
sd_y85 = np.sqrt(var_y85)
t95 = np.array(stats.t(n - 2).interval(0.95))
y85_confidence = y85 + t95 * sd_y85
print('A 95% confidence interval for the mean crime rate is ', 
      'when there are 85% high school grads is : ', y85_confidence)

# 8h
var_y85_pred = mse * (1 + 1/n + (x85 - mean_x) ** 2 / sxx)
sd_y85_pred = np.sqrt(var_y85_pred)
y85_mean_confidence = y85 + t95 * sd_y85_pred
print('A 95% confidence interval for the predicted crime rate is ', 
      'when there are 85% high school grads is : ', y85_mean_confidence)

# 9
ssr = ssto - sse
anova = pd.DataFrame({'ss': (ssto, sse, ssr)},
    index = ['ssto', 'sse', 'ssr'])
anova['df'] = (n - 1, n - 2, 1)
anova['ms'] = anova['ss'] / anova['df']
print(anova)

# 9d
f_star = ssr / (sse / (n-2))
f99 = stats.f(1, n - 2).ppf(0.99)
print('Reject h0 if {} is greater than {}'.format(f_star, f99))

# 9f
r2 = ssr / ssto
print('R square is : ', r2)
r2a = 1 - mse / anova['ms'][0]
print('Adjusted R square is : ', r2a)

# 9g
r = np.sign(b1) * np.sqrt(r2)
print('Correlation coefficient r is : ', r)
