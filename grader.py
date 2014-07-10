'''
grader.py

Utilities for grading programming assignments using Github
'''

import os
import subprocess
import requests


topdir = os.getcwd()

commands = ['pep8', 'pyflakes']


def build_dirs(students, topdir=topdir):
    '''
    Builds a directory structure in `topdir` with a folder for each student.
    `students` should be a sequence of github usernames.
    Looks like this:

    topdir/
        github/
            student1/
            ...
            studentn/

    '''
    gitdir = topdir + os.sep + 'github'
    os.mkdir(gitdir)

    for student in students:
        os.mkdir(gitdir + os.sep + student)


class grader(object):
    '''
    Downloads and runs command line executables on assignments

    Parameters  (all strings)
    ----------
    user        Github username
    repo        repository name
    branch      branch name (default master)
    filename    file name, with file extension
    topdir      top directory containing github directory with all students


    See also
    --------
    build_dirs to create the directory structure this class expects

    '''

    def __init__(self, user, repo, filename, branch='master', topdir=topdir):

        self.topdir = topdir
        self.user = user
        self.filename = filename

        # Strip the file extension off the end to get the assignment directory
        self.assignment = self.filename.split('.')[0]

        # Github URL where file is downloaded from
        self.url = '/'.join(['https://raw.githubusercontent.com', user, repo,
                            branch, filename])

        # The directory where the file will be downloaded to
        self.path = os.sep.join([self.topdir, 'github', self.user,
                                 self.assignment])

    def mkdir(self):
        '''
        Make the assignment directory
        '''
        os.mkdir(self.path)

    def download(self):
        '''
        Download file from Github and write to that user's directory
        '''
        self.response = requests.get(self.url)

        with open(self.path + os.sep + self.filename, 'w') as f:
            f.writelines(self.response.text)

    def shell_commands(self, commands=commands):
        '''
        Run command line executables and write results to assignment directory
        as log files
        '''
        for command in commands:
            logpath = self.path + os.sep + command + '.log'
            with open(logpath, 'w') as logfile:
                subprocess.call([command, self.filename], stdout=logfile)

    def process_all(self):
        '''
        Run all processing steps:

        1) Make a new directory
        2) Download file
        3) Run commands on file
        '''
        self.mkdir()
        self.download()
        self.shell_commands()


clark = grader(user='clarkfitzg', repo='junkyard', branch='master',
               filename='dirty.py')
