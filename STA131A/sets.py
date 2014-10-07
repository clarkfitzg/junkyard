'''
Exercise 2.8

Using lists rather than sets so it's easier to read
the elements in an ordered output. But they should be sets.
'''

from itertools import product

S = list(product(range(-3, 4), range(0, 5)))

events = {
        'A': lambda x: x[0] == x[1],
        'B': lambda x: x[0] == -x[1],
        'C': lambda x: x[0] ** 2 == x[1] ** 2,
        'D': lambda x: x[0] **2 + x[1] ** 2 <= 5,
}

print('S =\n', S)

for name, condition in sorted(events.items()):
    print(name, ' =\n', list(filter(condition, S)))
