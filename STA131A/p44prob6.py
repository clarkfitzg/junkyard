S = set(range(1, 201))

A = {x for x in S if x // 7 == 0}
B = {x for x in S if (x - 10) / 3}
C = {x for x in S if x ** 2 + 1 <= 375}

for letter, sets in zip('ABC', [A, B, C]):
