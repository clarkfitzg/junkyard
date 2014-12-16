'''
Linear programming in Python using COIN OR solvers

This worked well up to 1 million variables on my old Mac
Memory usage getting too big with 10 million variables
'''

from pulp import *

# Change this parameter- corresponds to dimension of hypercube
n = int(1e3)

# Variables
v = [LpVariable('x' + str(x)) for x in range(n)]

prob = LpProblem('Corner of a Hypercube', LpMaximize)

# objective function
prob += lpSum(v)

# The constraints
for vi in v:
    prob += vi <= 1

prob.solve()

print(LpStatus[prob.status])

# If this is 1 then it found the corner
print(set(vi.varValue for vi in v))
