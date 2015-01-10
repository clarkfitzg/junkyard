import numpy as np
import pandas as pd
import statsmodels.formula.api as smf
import matplotlib.pyplot as plt


lake = pd.read_csv('lake.dat', names=['level'])
lake['t'] = lake.index

# Level changing over time
plt.plot(lake['t'], lake['level'])

mod = smf.ols('level ~ t', data=lake)
res = mod.fit()

# linear fit
plt.plot(lake['t'], res.predict(lake))

# quadratic fit
res2 = smf.ols('level ~ t + t^2', data=lake).fit()
plt.plot(lake['t'], res2.predict(lake))

plt.savefig('lakefit.pdf')
