'''
thread_download.py

Use threads to download many websites.

Command line argument is number of threads
to use. Try running it with 5, 10, 20 and watch the processes on
your system monitor.

Command line usage:

$ python thread_download.py 20

'''

from concurrent.futures import ThreadPoolExecutor
import time
import argparse

import requests


companies = ['google', 'yahoo', 'msn', 'cisco', 'facebook', 'twitter',
             'stackoverflow', 'expedia', 'amazon', 'zappos', 'linkedin',
             'youtube', 'blogspot', 'bing', 'ebay', 'nytimes', 'hotels',
             'ask', 'tumblr', 'paypal']

urls = ['http://www.' + name + '.com' for name in companies]


def getprint(url):
    '''
    Lets us know when downloads begin and end
    '''
    print('fetching ', url)
    result = requests.get(url)
    print(url, ' has been downloaded')


def main(max_workers):

    start_parallel = time.time()

    # Note that this map code will be at least as slow as the slowest response.
    # Using a with statement apparently removes the processes once
    # they are finished, judging by the processes shown by the OS

    with ThreadPoolExecutor(max_workers=max_workers) as pool:
        out_parallel = pool.map(getprint, urls)

    print('\n  parallel version took:', time.time() - start_parallel, '\n')

    start_serial = time.time()

    out_serial = [getprint(url) for url in urls]

    print('\n  serial version took: ', time.time() - start_serial, '\n')


if __name__ == '__main__':

    # Command line arguments for number of processes
    parser = argparse.ArgumentParser()
    parser.add_argument('max_workers', type=int)
    args = parser.parse_args()

    main(args.max_workers)
