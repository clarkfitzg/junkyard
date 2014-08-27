'''
loop over 7 GB file and count Tags

Takes 6.3 minutes
'''

from time import time
import csv
import collections

start_time = time()

count = collections.Counter()

with open('/Users/clark/data/facebook/Train.csv') as Train:
    for row in csv.DictReader(Train):
        # split tag column on whitespace
        tags = row['Tags'].split(' ')
        count.update(tags)

end_time = time()

print(end_time - start_time)
