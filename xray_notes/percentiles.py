import numpy as np
import xray

a = xray.DataArray(np.random.randn(10, 3))

def percent90(x): 
    return np.percentile(x, 90)

a.groupby('dim_1').apply(percent90)
