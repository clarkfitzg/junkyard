'''
Exercise 2.8

Using lists rather than sets so it's easier to read
the elements in an ordered output. But they should be sets.
'''

from itertools import product

S = list(product(range(-3, 4), range(0, 5)))

events = {
        'A': [(x, y) for x, y in S if x == y],
        'B': [(x, y) for x, y in S if x == -y],
        'C': [(x, y) for x, y in S if x ** 2 == y ** 2],
        'D': [(x, y) for x, y in S if x ** 2 + y ** 2 <= 5],
}

print('S =\n', S)

for name, event in sorted(events.items()):
    print(name, ' =\n', event)
