'''
Interval class
'''


class Interval(object):
    '''
    Numeric intervals
    '''
    def __init__(self, a, b):
        self.a = a
        self.b = b

    def __contains__(self, x):
        return self.a <= x <= self.b


if __name__ == '__main__':
    a = Interval(0, 2)

    # Expect True
    print(1 in a)
