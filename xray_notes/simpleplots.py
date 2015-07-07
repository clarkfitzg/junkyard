import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import xray


d = [0, 1, 0, 2]
a = xray.DataArray(d, coords={'period': range(len(d))})
