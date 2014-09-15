import numpy as np
from numpy.testing import assert_equal

from bootstrap import bootstrap


class test_bootstrap():

    def test_default_init(self):
        bootstrap(np.ones(5))

    def test_iter_value(self):
        actual = bootstrap(np.ones(5), np.mean)
        assert_equal(1.0, next(actual))

    def test_iter_decrements_reps(self):
        actual = bootstrap(np.ones(5), np.mean, reps=50)
        next(actual)
        assert_equal(49, actual.reps)

    def test_list_comprehension(self):
        b = bootstrap(np.ones(5), np.mean, reps=5)
        actual = [x for x in b]
        assert_equal([1] * 5, actual)

    def test_len(self):
        actual = bootstrap(np.ones(5), np.mean, reps=50)
        assert_equal(50, len(actual))
