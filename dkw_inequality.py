'''
Using the Dvoretzky-Kiefer-Wolfowitz (DKW) Inequality to make nonparametric
confidence sets for a cumulative distribution function.

P. 99 of Wasserman's All of Statistics
'''

from functools import partial
import numpy as np
import pandas as pd
#import matplotlib.pyplot as plt
from scipy.stats import percentileofscore


points = np.arange(11)
cdf = np.vectorize(partial(percentileofscore, points))


df = pd.DataFrame({'x': np.linspace(-3, 13, num=100)})
df.index = cdf(df.x)
