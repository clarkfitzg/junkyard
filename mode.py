from collections import namedtuple

def mode(a, axis=0):
    # ...
    ModeResult = namedtuple('ModeResult', ('mode', 'count'))
    return ModeResult(10, 20)

b = mode(10)
print(str(b), repr(b), type(b))
