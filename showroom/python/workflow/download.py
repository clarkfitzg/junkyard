'''
Download and unzip the 2006 US import data from the UC Davis Center for
Economic Data
'''

from tempfile import TemporaryFile
from zipfile import ZipFile

from requests import get


response = get('http://cid.econ.ucdavis.edu/data/sasstata/usiss/imp06.zip')

temp = TemporaryFile()
temp.write(response.content)

# Write extracted file into working directory
with ZipFile(temp) as tempzip:
    tempzip.extract('imp06_con.dta')
