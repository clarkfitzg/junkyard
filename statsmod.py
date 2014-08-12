'''
Working through the statsmodels examples
'''

import statsmodels.api as sm
import pandas as pd
from patsy import dmatrices

url = "http://vincentarelbundock.github.com/Rdatasets/csv/HistData/Guerry.csv"

df = pd.read_csv(url)

vars = ['Department', 'Lottery', 'Literacy', 'Wealth', 'Region']



