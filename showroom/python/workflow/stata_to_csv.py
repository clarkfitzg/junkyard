'''
Transform the proprietary Stata file into simple CSV
'''

import pandas as pd


imp06_con = pd.read_stata('imp06_con.dta')

imp06_con.to_csv('imp06_con.csv', index=False)
