import sys

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import xray

# What does squeeze do?
# Knocks off the dimensions of length 1

a = xray.DataArray(np.random.randn(1, 5))
a.squeeze()

df = pd.DataFrame({'a': range(5), 'b': range(5)})

# What does the select do?
df.select(lambda x: x == 2)

(pd.DataFrame({'a': range(5), 'b': range(5)})
        .mean(skipna=False)
        .sum()
)
