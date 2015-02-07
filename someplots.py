'''
Make a few plots and save to disk
'''

from scipy import stats
import numpy as np
import matplotlib.pyplot as plt

x = np.random.randn(1000)
a = np.linspace(-4, 4)
Z = stats.norm()

plt.hist(x, normed=True)
plt.plot(a, Z.pdf(a))

plt.savefig('normal.pdf')
