"""
"""

import os

from pandas import DataFrame
from dbfread import DBF

path = os.path.expanduser("~/data/fars/2013/cevent.dbf")

table = DBF(path)

cevent = DataFrame(iter(table))
