'''
Practicing a linear model using statsmodels
'''

import pandas as pd
import statsmodels.formula.api as smf


gmat = pd.read_csv('/Users/clark/data/gmat.csv')
gmat.columns = ['experience', 'days_prep', 'gpa', 'female', 'gmat']

mod = smf.ols(formula='gmat ~ experience + days_prep + gpa + female',
              data=gmat).fit()

print(mod.summary())
