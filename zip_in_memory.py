'''
Figuring out how to work with zip files in memory
'''

import io
from tempfile import TemporaryFile
from zipfile import ZipFile

import requests
import pandas as pd


# Typical CSV file content
df = pd.DataFrame({'a': (1, 2), 'b': (3, 4)})

fname = 'stata_out.dta'

# write file to disk
df.to_stata(fname)


# Write to zipfile
with open(fname, 'rb') as source, ZipFile('stata.zip', mode='w') as target:
    target.writestr(fname, source.read())

# Read out the bytes
with ZipFile('stata.zip').open(fname) as z:
    fb = io.BytesIO(z.read())

df2 = pd.read_stata(fb)


# Try it on the web:
url = 'http://download.geonames.org/export/zip/BD.zip'
response = requests.get(url)

archive = ZipFile(io.BytesIO(response.content))

df = pd.read_csv(archive.open('BD.txt'))
