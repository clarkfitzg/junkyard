'''
Try parsing the HTML with Python to understand what R is doing.
'''

from lxml import etree

tree = etree.parse('hackernews.html', etree.HTMLParser())

headlines = tree.xpath("//td[@class='title']/a/text()")
