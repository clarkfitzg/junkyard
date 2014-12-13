'''
Linear programming in Python using 3rd party solvers
'''

import math
from pulp import *

# Variables
v = [LpVariable('x' + str(x)) for x in range(5)]

# Create the 'prob' variable to contain the problem data
prob = LpProblem('Corner of a Hypercube', LpMaximize)

# The objective function is added to 'prob'
prob += lpSum(v)

# The constraints
for vi in v:
    prob += vi <= 1

# The problem is solved using PuLP's choice of Solver
prob.solve()

prob.writeLP('hypercube.lp')

# The status of the solution is printed to the screen
print(LpStatus[prob.status])

# Each of the variables is printed with it's resolved optimum value
for v in prob.variables():
    print(v.name, "=", v.varValue)
