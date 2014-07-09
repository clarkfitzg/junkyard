'''
test_grader.py
'''

import os
import nose

from grader import build_dirs


class test_build_dirs():
    
    def test_student_dir_created(self):
        build_dirs(['stu1', 'stu2'])
        newdir = 'github' + os.sep
        nose.tools.assert_true(os.path.isdir(newdir + 'stu1'))
        nose.tools.assert_true(os.path.isdir(newdir + 'stu2'))

    @nose.tools.raises(FileExistsError)
    def test_dont_write_existing(self):
        os.mkdir('github')
        build_dirs(['stu1', 'stu2'])




