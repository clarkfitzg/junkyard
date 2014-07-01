'''
parallel downloader
'''

import multiprocessing
import time

import requests


companies = ['google', 'yahoo', 'msn', 'cisco', 'facebook', 'twitter',
        'stackoverflow', 'github', 'amazon', 'zappos', 'linkedin', 
        'youtube', 'blogspot', 'bing', 'ebay', 'pinterest', 'instagram',
        'ask', 'tumblr', 'paypal']

urls = ['http://www.' + name + '.com' for name in companies]

def main(num_process):
    pool = multiprocessing.Pool(processes=num_process)

    start_parallel = time.time()

    # Note that this map code will be at least as slow as the slowest response.
    out_parallel = pool.map(requests.get, urls)

    print('parallel version took:')
    print(time.time() - start_parallel)

    start_serial = time.time()

    out_serial = [requests.get(url) for url in urls]

    print('serial version took:')
    print(time.time() - start_serial)

