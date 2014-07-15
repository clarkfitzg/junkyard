'''
Generate random uniform numbers and save to file
'''

import random
import csv


data = ((i, random.random()) for i in range(10))

with open('data.csv', 'w') as f:
    pen = csv.writer(f)
    pen.writerows(data)
