'''
combinations.py

Demonstrate itertools using basic statistical concepts

In this simple card game each card has a value.
A player draws 5 cards without replacement and sums their values
to determine their final score.

Task:
Visualize the probability distribution for scores from this card game
'''

import itertools


suits = {'clubs', 'spades', 'hearts', 'diamonds'}

# Face cards have these values:
cards = {'jack': 13, 'queen': 17, 'king': 18, 'ace': 50}

# Numbered cards are worth twice their face value
nums = range(2, 11)
numbered_cards = zip(nums, (2 * x for x in nums))
cards.update(numbered_cards)

# The cartesian product of cards and suits produces the deck
deck = itertools.product(cards.keys(), suits)

# There are 52 choose 5 possible hands:
sample_space = itertools.combinations(deck, 5)


def random_variable(hand):
    '''
    Random variables are functions from the sample space to the real line.
    This one sums the values of the cards in the hand by
    looking up the value of cards in the module namespace.

    >>> hand = ((5, 'C'), (5, 'S'), (5, 'H'), (5, 'D'), (2, 'C'))

    >>> random_variable(hand)
    44

    '''
    return sum(cards[x[0]] for x in hand)


pdist = map(random_variable, sample_space)


# We get a discrete probability distribution by applying the
# random variable to every element in the sample space.
#
# Analyze this result in Ipython notebook with:
#
# dist = pd.Series(list(pdist))
# dist.hist(bins=100)


if __name__ == '__main__':
    import doctest
    doctest.testmod()
