'''
maintain_sort.py

Combine two lists which are already in sorted order.
'''

from heapq import merge

a = [1, 3, 7]
b = [2, 4, 20]

# The right way
c = list(merge(a, b))

# The crazy way
def crazymerge(a=a, b=b):
    try:
        a_last = a[-1]
        b_last = b[-1]
    except IndexError:

    if a_last > b_last:
        yield a.pop()
    else:
        yield b.pop()

c2 = list(crazymerge(a, b))
