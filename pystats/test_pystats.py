from nose.tools import assert_equal, raises
from pystats import weighcount, binom


class test_weighcount:

    def setup(self):
        self.wc = weighcount({'a': 2, 'b': 8, 'c': 10})

    def test_total(self):
        assert_equal(self.wc.total(), 20)

    def test_single_weight(self):
        assert_equal(self.wc.weight('a'), 0.1)

    def test_common_weights_all(self):
        all_weights = [('c', 0.5), ('b', 0.4), ('a', 0.1)]
        assert_equal(self.wc.common_weights(), all_weights)

    def test_common_weights_n(self):
        assert_equal(self.wc.common_weights(2), [('c', 0.5), ('b', 0.4)])


class test_binom:

    def test_backwards(self):
        assert_equal(binom(5, 3), 10)

    def test_returns_integer(self):
        assert_equal(type(binom(5, 4)), int)

    @raises(TypeError)
    def test_floats_raise_TypeError(self):
        binom(5, 3.5)
