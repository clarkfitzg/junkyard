from pprint import pprint

print('How many globals are in Python?')

g = globals()

print(len(g))

pprint(g)

print('\nname is {}'.format(g['__name__']))
