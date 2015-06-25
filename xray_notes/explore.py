import numpy as np
import xray

# What does squeeze do?
# Knocks off the dimensions of length 1

a = xray.DataArray(np.random.randn(1, 5))
a.squeeze()
