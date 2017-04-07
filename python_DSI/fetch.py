"""
Fetch incidents from the bing API

Following
https://msdn.microsoft.com/en-us/library/hh441726.aspx
"""

import json
import requests


with open("bing_key.txt") as f:
    key = f.read().rstrip()

# South Latitude, West Longitude, North Latitude, East Longitude
bbox = "38,-122,39,-121"

baseurl = "http://dev.virtualearth.net/REST/v1/Traffic/Incidents/" + bbox

response = requests.get(baseurl, {"key": key})

incidents = response.json()['resourceSets'][0]['resources']

with open("incidents.json", "w") as f:
    json.dump(incidents, f)
