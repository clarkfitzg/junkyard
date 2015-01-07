import statsmodels.api as sm
import statsmodels.formula.api as smf
import pandas as pd

bodyfat = pd.read_fwf('bodyfat.txt', names=['dietfat', 'bodyfat'])

fatmodel = smf.ols('bodyfat ~ dietfat', bodyfat)

fatresults = fatmodel.fit()

sm.qqplot(fatresults.resid, line='s')
