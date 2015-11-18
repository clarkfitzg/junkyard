'''
test_hw_collector.py

Run tests by issuing command `nosetests` from this directory.
'''

import os
import shutil
import mock
from nose.tools import assert_equal, assert_true, raises

from hw_collector import initialize, download, grader


# Set leave_testdir to True to manually inspect results
leave_testdir = True

testdir = os.getcwd() + os.sep + 'TESTING'
usernames = ['student1', 'student2']

student1 = grader(filename='assign1.py', username='student1',
                  content='a=range(10 and then)\n  b=[]  \n', topdir=testdir)


def setup_module():
    try:
        shutil.rmtree(testdir)
    except FileNotFoundError:
        pass
    os.mkdir(testdir)
    initialize(usernames, testdir)


def teardown_module():
    '''
    Removes testdir and everything in it
    '''
    if leave_testdir:
        pass
    else:
        shutil.rmtree(testdir)


class test_initialize():

    def test_makes_directory(self):
        new_dir = os.sep.join([testdir, 'github', 'student1'])
        assert_true(os.path.isdir(new_dir))

    @raises(FileExistsError)
    def test_wont_write_over_existing_directories(self):
        initialize(usernames, testdir)


@mock.patch('hw_collector.requests.get')
def test_download(mock_get):
    download('test.py', 'user1', repo='project', branch='master')
    url = 'https://raw.githubusercontent.com/user1/project/master/test.py'
    mock_get.assert_called_with(url)


class test_grader():

    @classmethod
    def setup_class(cls):
        student1.mkdir()
        student1.write_content()

    def test_correct_path(self):
        assign1dir = os.sep.join([testdir, 'github', 'student1', 'assign1'])
        assert_equal(assign1dir, student1.path)

    def test_mkdir(self):
        assert_true(os.path.isdir(student1.path))

    def test_write_content(self):
        with open(student1.path + os.sep + student1.filename) as f:
            assert_equal(student1.content, f.read())

    def test_shell_command_pyflakes(self):
        student1.shell_commands(['pyflakes'])
        with open(student1.path + os.sep + 'pyflakes.log') as f:
            assert_true('unexpected indent' in f.read())

    def test_shell_command_pep8(self):
        student1.shell_commands(['pep8'])

        errors = {'E225 missing whitespace around operator',
                  'E111 indentation is not a multiple of four',
                  'E113 unexpected indentation',
                  'E225 missing whitespace around operator',
                  'W291 trailing whitespace',
                  }

        with open(student1.path + os.sep + 'pep8.log') as f:
            log_contents = f.read()
            for error in errors:
                assert_true(error in log_contents)

    @raises(TypeError)
    def test_shell_command_wont_do_strings(self):
        student1.shell_commands('pyflakes')

    def test_writes_relative_path(self):
        student1.shell_commands(['pep8'])
        with open(student1.path + os.sep + 'pep8.log') as f:
            assert_true(any(line.startswith('assign1.py') for line in f))
