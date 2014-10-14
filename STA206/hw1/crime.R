# crime.R

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
constant = 1 / (sum_x2 - n * mean_x ** 2)
b1 = constant * (sum_xy - mean_x * sum_y)
b0 = mean_y - b1 * mean_x
print(c('b0 and b1 are : ', b0, b1))

# 8b
ssto = sum_y2 - 2 * mean_y * sum_y + n * mean_y
sxx = sum_x2 - 2 * mean_x * sum_x + n * mean_x

sse = ssto + (b1 ** 2) * sxx
mse = sse / (n - 2)
print(c('sse and mse are : ', sse, mse))

# 8c
var_y = ssto / (n - 1)
sd_y = sqrt(var_y)

sd_b0 = var_y * (1/n + mean_x ** 2 / sxx)
sd_b1 = var_y / sxx
print(c('standard errors for b0 and b1 are : ', sd_b0, sd_b1))
