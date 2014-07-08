'''
Downloads, checks, and records style for Python code
'''

import subprocess
import requests


user = 'clarkfitzg'
repo = 'junkyard'
file_name = 'dirty.py'
branch = 'master'

url = '/'.join(['https://raw.githubusercontent.com', user, repo,
               branch, file_name])

response = requests.get(url)

# Record the actual file created by the student
with open(assign_name, 'w') as f:
    f.writelines(response.text)


def record_output(command, assign_name=assign_name):
    '''
    Records the output of the shell command in the current directory
    '''
    with open(command + '.txt', 'w') as target:
        subprocess.call([command, assign_name], stdout=target)


commands = ['pep8', 'pyflakes']

# Make a file for the output of each command
for command in commands:
    record_output(command)
