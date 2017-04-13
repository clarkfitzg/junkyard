#!/usr/bin/env python

"""
Download all the FARS data from the FTP server
"""

import ftplib

ftp = ftplib.FTP("ftp.nhtsa.dot.gov")

ftp.login()

# Navigate into the FARS directory
ftp.cwd("FARS")

years = ftp.nlst()

year = "1986"

ftp.cwd(year)

ftp.cwd("DBF")

fname = ftp.nlst()[0]

# Retrieve binary files and write them to the local machine
with open(fname, "wb") as f:
    ftp.retrbinary("RETR {}".format(fname), f.write)
