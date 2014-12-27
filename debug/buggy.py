a = range(5)

for i in a:
    print(i)

def iseven(x):
    return x // 2 == 0

n = int(1e5)

c = sum(iseven(x) for x in range(n))

print(c)
