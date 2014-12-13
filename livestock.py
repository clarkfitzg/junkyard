'''
Linear programming in Python using 3rd party solvers

As copied from 
http://www.coin-or.org/PuLP/CaseStudies/a_blending_problem.html
'''

import math
from pulp import *

# Variables
x1 = LpVariable('cows', 0, cat='Integer')
x2 = LpVariable('sheep', 0, cat='Integer')

# Create the 'prob' variable to contain the problem data
prob = LpProblem('Cows and Sheep', LpMaximize)

# The objective function is added to 'prob'
prob += 100 * x1 + 18 * x2, 'Value of livestock'

# The constraints
prob += 4 * x1 + x2 <= 100, 'Grazing'
prob += x2 >= 5, 'Minimum number sheep'

# The problem data is written to an .lp file
prob.writeLP('livestock.lp')

# The problem is solved using PuLP's choice of Solver
prob.solve()

# The status of the solution is printed to the screen
print(LpStatus[prob.status])

# Each of the variables is printed with it's resolved optimum value
for v in prob.variables():
    print(v.name, "=", v.varValue)
