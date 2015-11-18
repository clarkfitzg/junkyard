'''
Creates a histogram of the normal distribution
'''

from matplotlib import pyplot as plt
from scipy.stats import norm

norm_pts = norm().rvs(1000)

plt.hist(norm_pts)
# Title looks ugly in tex paper.
#plt.title('standard normal') 
plt.savefig('normal_py.pdf')
