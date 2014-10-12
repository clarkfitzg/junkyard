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
sse = sum_y2 - 2 * mean_y * sum_y + n * mean_y -
      (b1 ** 2) * (sum_x2 - 2 * mean_x * sum_x + n * mean_x)
mse = sse / (n - 2)
print(c('sse and mse are : ', sse, mse))

# 8c
