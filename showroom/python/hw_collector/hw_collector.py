#! /usr/bin/env python3
'''
hw_collector.py

Utilities for collecting and grading programming assignments using Github

Initialize by setting the script level parameters for the course, and then
run `initialize` to build the file structure. 
After that use it as a command line program:

    $ python hw_collector assignment.py

This will pull `assignment.py` down from github into a new directory and
run the commands on it, recording the results as log files.
'''

import os
import subprocess
import itertools
from os.path import join
from datetime import datetime
from argparse import ArgumentParser
from concurrent.futures import ThreadPoolExecutor
import requests


# Script level parameters
########################################

# github folder with student names should be located inside `topdir`
topdir = os.getcwd()

# Github info
repo = '2015-python-course'
branch = 'master'

# Number of threads to use for downloading
num_threads = 5

# This should be replaced by some io
usernames = ['nick-ulle', 'clarkfitzg', 'christopheraden']

# Shell commands to run on each file
commands = ['pep8', 'pyflakes']

########################################


def initialize(usernames=usernames, topdir=topdir):
    '''
    Builds a directory structure in `topdir` with a folder for each username.
    `usernames` should be a sequence of github usernames.
    Looks like this:

    topdir/
        github/
            username1/
            username2/
            ...

    '''
    gitdir = join(topdir, 'github')
    os.mkdir(gitdir)

    for username in usernames:
        os.mkdir(join(gitdir, username))


def download(filename, username, repo=repo, branch=branch):
    '''
    Download raw file from Github
    '''
    base_url = 'https://raw.githubusercontent.com'
    url = '/'.join([base_url, username, repo, branch, filename])
    print('fetching ', url)
    response = requests.get(url)
    print('downloaded ', username)
    return filename, username, response.text


class grader(object):
    '''
    Writes files, manages directory structure,
    and runs command line executables on assignments

    Parameters  (all strings)
    ----------
    filename    file name, with file extension
    username    Github username
    content     file content as downloaded from Github
    topdir      top directory containing github directory with all students

    See also
    --------
    `initialize` to create the directory structure this class expects

    '''

    def __init__(self, filename, username, content, topdir=topdir):

        self.filename = filename
        self.username = username
        self.content = content
        self.topdir = topdir

        # Strip the file extension off the end to get the assignment
        self.assignment = self.filename.split('.')[0]

        # Assignment directory
        self.path = join(topdir, 'github', username, self.assignment)
        # Actual location of file
        self.filepath = join(self.path, filename)

    def mkdir(self):
        '''
        Make the assignment directory
        '''
        os.mkdir(self.path)

    def write_content(self):
        '''
        Write file into the assignment directory
        '''
        with open(self.filepath, 'w') as f:
            f.writelines(self.content)

    def shell_commands(self, commands=commands):
        '''
        Run command line executables and write results to assignment directory
        as log files. Commands should be a list.
        '''
        if isinstance(commands, str):
            raise TypeError('The commands should be in a list.')

        # Change the directory so it doesn't write full path in log file
        os.chdir(self.path)

        header = ('Running {cmd} on {filepath}\nCurrent time is {time}\n\n')

        for command in commands:
            # Capturing the output in this way will allow us to extend
            # this later- like putting it into a database

            output = subprocess.getoutput(' '.join([command, self.filename]))
            logpath = join(self.path, command + '.log')
            top = header.format(cmd=command, filepath=self.filepath,
                                time=datetime.now())

            with open(logpath, 'w') as logfile:
                logfile.write(top)
                logfile.write(output)

    def allsteps(self):
        '''
        Run all processing steps

        1) Make a new directory
        2) Write downloaded file into directory
        3) Run commands on file
        '''
        self.mkdir()
        self.write_content()
        self.shell_commands()


def collect(filename, usernames=usernames):
    '''
    Collect and run grader on the assignment for each username
    '''

    # Keep the threaded download separate from the processing
    with ThreadPoolExecutor(num_threads) as pool:
        allfiles = pool.map(download, itertools.repeat(filename), usernames)

    for user in itertools.starmap(grader, allfiles):
        user.allsteps()


if __name__ == '__main__':

    parser = ArgumentParser()
    parser.add_argument('filename', type=str)
    args = parser.parse_args()

    collect(args.filename)
