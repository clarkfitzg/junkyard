'''
ch 10 exercise 7 

Null hypothesis is that the means are equal, or equivalently
that the difference of the means is 0.

This could be easily generalized to comparing any two means 
'''


import numpy as np
from scipy import stats

twain = [0.225, 0.262, 0.217, 0.240, 0.230, 0.229, 0.235, 0.217]
snodgrass = [0.209, 0.205, 0.196, 0.210, 0.202, 0.207, 0.224, 0.223, 0.220, 0.201]

# non parametric plug in estimator
sehat = np.sqrt(np.var(twain) ** 2 / len(twain) +
                np.var(snodgrass) ** 2 / len(snodgrass))
delta = np.mean(snodgrass) - np.mean(twain)

# Wald statistic
Wald = (delta) / sehat

# Tiiiiny!
pvalue = 2 * stats.norm.cdf(-abs(Wald))

# 95 percent confidence interval - very tight
conf95 = delta + sehat * np.array(stats.norm.interval(0.95))

message = '''
We tested the hypothesis that the means between the arrays were equal.
The 95 percent confidence interval for the difference between the means
is {conf95} and the pvalue is {pvalue}. From this we conclude with 
high confidence that the two authors used three letter words with
different frequencies, implying some difference in writing style.

This casts doubt on the belief that Twain is Snodgrass.
'''.format(conf95=conf95, pvalue=pvalue)

print(message)
