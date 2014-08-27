'''
Some simple probability questions from 'Mathematical Stats and Data Analysis'
by John Rice.
'''

from scipy.special import binom
from scipy import stats

# p.65 question 13

# Custom code - k_correct is the probability mass function,
# while atleast12 is the survival function

def k_correct(k, choices=3):
    ans = (1/choices) ** k 
    ans *= binom(20, k) 
    ans *= ((choices-1)/choices) ** (20-k) 
    return ans

def atleast12(choices):
    return sum(k_correct(k, choices=choices) for k in range(12, 21))

print(atleast12(3))


# A better way- just use scipy.stats
result = stats.binom(20, 1/3).sf(11)
print(result)
