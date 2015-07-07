'''
Following this example:
http://xray.readthedocs.org/en/stable/examples/weather-data.html
'''

import xray
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns # pandas aware plotting library

np.random.seed(123)

times = pd.date_range('2000-01-01', '2001-12-31', name='time')
annual_cycle = np.sin(2 * np.pi * (times.dayofyear / 365.25 - 0.28))

base = 10 + 15 * annual_cycle.reshape(-1, 1)
tmin_values = base + 3 * np.random.randn(annual_cycle.size, 3)
tmax_values = base + 10 + 3 * np.random.randn(annual_cycle.size, 3)

ds = xray.Dataset({'tmin': (('time', 'location'), tmin_values),
                   'tmax': (('time', 'location'), tmax_values)},
                  {'time': times, 'location': ['IA', 'IN', 'IL']})

ds.mean(dim='location').to_dataframe().plot()
