
def template_maker(template):
    def output(a, b):
        print(template.format(a, b))
    return output

d = {'a': 1, 'b': 2}

def gen(mydict):
    innerdict = mydict.copy()
    while True:
        yield innerdict['a']

g1 = gen(d)
