'''
moddict.py

'''
from functools import wraps

d = {'clark': 10, 'yeji': 20}

class moddict(dict):
    '''
    Modifying behavior
    '''
    def __getitem__(self, key):
        print('Someone just looked up {}'.format(key))
        return super(moddict, self).__getitem__(key)

    def __getattribute__(self, name):
        print('I own the dot!!!')
        return super(moddict, self).__getattribute__(name)

    def __f__(self):
        print('Called f on moddict')
        return 37

    def __len__(slef):
        print('wicked long')
        return 'twenty'

    @property
    def shape(self):
        '''
        Property docstring
        '''
        return (32, 23)


def f(x):
    return x.__f__()

def len(x):
    '''
    Writing over the builtin len
    '''
    return x.__len__()

e = moddict()
e['clark'] = 20
e['yeji'] = 30

print(e['clark'])
