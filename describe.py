from collections import namedtuple
from scipy.stats import describe, norm


data = norm().rvs(100)
unnamed = describe(data)

output = namedtuple('describe', ('size', 'range', 'mean', 'variance', 
                                 'skewness', 'kurtosis'))

named = output(*unnamed)

