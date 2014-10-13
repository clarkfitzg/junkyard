import operator
import math
import random

from numba import autojit


n = 100
x = [random.random() for i in range(n)]
y = list(range(n))

def pydot(x, y):
    '''
    dot product in Python
    '''
    sum(map(operator.mul, x, y))


numbadot = autojit(pydot)
