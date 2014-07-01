'''
Scrape Davis housing data from Craigslist.
'''

import csv
import multiprocessing
from urllib.robotparser import RobotFileParser

import requests
import bs4


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
    Extract relevant info from a single HTML tag.
    '''
    # try / except block performs error handling for missing data
    try:
        price = tag.find('span', {'class': 'price'}).text.replace('$', '')
        loc = tag.small.text
        desc = tag.find('span', {'class': 'pl'}).a.text
        return price, loc, desc
    except AttributeError:
        return ('', '', '')


def to_csv(content, filename):
    '''
    Write extracted results to a CSV file.
    '''
    with open(filename, 'w') as target:
        writer = csv.writer(target)

        # Add a row for the header
        writer.writerow(('price', 'location', 'description'))

        # Write in the main data
        writer.writerows(content)


def get_one(page):
    '''
    get a single response
    '''

    url = ('http://sacramento.craigslist.org/apa/'
           'index{}00.html'.format(page))

    # Send the HTTP GET request using the full URL
    craig_response = requests.get(url)

    # Parse the response using BeautifulSoup
    craig_soup = bs4.BeautifulSoup(craig_response.content)

    # Look in the 'p' tag elements to find just the actual listings
    ptags = craig_soup.find_all('p')

    # Apply the extract function to every element in ptags
    return map(extract, ptags)


craig_pool = multiprocessing.Pool(processes=4)
