'''
parallel downloader
'''

import multiprocessing
import time

import requests


companies = ['google', 'yahoo', 'msn', 'cisco', 'facebook', 'twitter',
        'stackoverflow', 'github', 'amazon', 'zappos']

urls = ['http://www.' + name + '.com' for name in companies]

pool = multiprocessing.Pool(processes=10)

start_parallel = time.time()
out_parallel = pool.map(requests.get, urls)

print('parallel version took:')
print(time.time() - start_parallel)

start_serial = time.time()

out_serial = [requests.get(url) for url in urls]

print('serial version took:')
print(time.time() - start_serial)

