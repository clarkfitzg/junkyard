"""
Download 
"""

import requests


with open("bing_key.txt") as f:
    key = f.read().rstrip()

baseurl = "http://dev.virtualearth.net/REST/v1/Traffic/Incidents/37,-105,45,-94"

response = requests.get(baseurl, {"key": key})

out = response.json()
