# Understanding Python's scoping rules

def f_outer(x):
    y = 10
    return x

def f_inner(x):
    return x + y

# Fails
f_outer(f_inner(10))
