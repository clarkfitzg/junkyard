'''
Looking at Amazon's books for data analysis

'http://www.amazon.com/s/ref=sr_pg_2?rh=n%3A283155%2Cn%3A%211000%2Cn%3A5%2Cn%3A549646%2Cn%3A3654&page=1&ie=UTF8'
'''

import multiprocessing
import re
import bs4
import requests
from urllib.robotparser import RobotFileParser

base_url = 'http://www.amazon.com'
ext_url = '/s/ref=sr_pg_2?rh=n%3A283155%2Cn%3A%211000%2Cn%3A5%2Cn%3A549646%2Cn%3A3654&page=1&ie=UTF8'
res_regex = re.compile('result_[0-9]{,}')


def check_robots(base_url, ext_url):
    '''
    Check the robots.txt
    Prints note if base_url + ext_url is legal for crawling
    '''
    bot = RobotFileParser(base_url + '/robots.txt')
    bot.read()
    if bot.can_fetch('*', base_url + ext_url):
        print('robots.txt permits parsing')
    else:
        print('Do not parse')
    return bot


def extract(tag):
    '''
    Want to extract title, author, publication date, review stars.
    Just doing title for the moment
    '''
    return tag.find('div', 'productTitle').a.text


def fetch_one(k=1):
    '''
    Fetch the kth page of the search results
    '''
    response = requests.get('http://www.amazon.com/s/ref=sr_pg_{}'
            '?rh=n%3A283155%2Cn%3A%211000%2Cn%3A5%2Cn%3A549646%2Cn'
            '%3A3654&page=1&ie=UTF8'.format(k))

    soup = bs4.BeautifulSoup(response.content)
    
    booktags = soup.find_all(id=res_regex)
    return list(map(extract, booktags))


#soup = fetch_one()

pool = multiprocessing.Pool(processes=5)



