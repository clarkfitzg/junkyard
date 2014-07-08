'''
iterable_cards.py

This script demonstrates core data structures and iterables in Python 3
using basic statistical concepts. Pay attention to what lazy evaluation
does for the program's memory usage.

In this simple card game each card has a value.
A player draws 5 cards without replacement and sums their values
to determine their final score.

Task:
Visualize the probability distribution for scores from this card game.
'''

import itertools
import collections
from math import factorial


suits = {'clubs', 'spades', 'hearts', 'diamonds'}

# Face cards have these values:
cards = {'jack': 13, 'queen': 17, 'king': 18, 'ace': 50}

# Numbered cards are worth twice their face value
nums = range(2, 11)
numbered_cards = zip(nums, (2 * x for x in nums))

cards.update(numbered_cards)


def score(hand):
    '''
    Random variables are functions from the sample space to the real line.
    This one sums the values of the cards in the hand by
    looking up the value of cards in the module namespace.

    >>> hand = ((5, 'C'), (5, 'S'), (5, 'H'), (5, 'D'), (2, 'C'))
    >>> score(hand)
    44

    '''
    return sum(cards[x[0]] for x in hand)


def allhands(handsize=5, random_variable=score):
    '''
    Returns an iterator that applies a random variable to each
    possible hand of size `handsize`.

    >>> small = list(allhands(1))
    >>> small[:4]
    [4, 4, 4, 4]
    >>> len(small)
    52

    '''
    # The cartesian product of cards and suits produces a deck of cards.
    deck = itertools.product(cards.keys(), suits)

    # This iterator produces all possible combinations of 5 card hands.
    sample_space = itertools.combinations(deck, handsize)

    # Apply the random variable to every element in the sample space.
    return map(random_variable, sample_space)


def n_choose_k(n, k):
    '''
    Naive calculation of n choose k combinations. Use this function
    to verify expecations.

    >>> n_choose_k(52, 5)
    2598960

    '''
    return factorial(n) // (factorial(n - k) * factorial(k))


# A couple things to try:
#
# score_counts = collections.Counter(allhands())
#
# dist = pd.Series(list(allhands()))
# dist.hist(bins=100)


if __name__ == '__main__':
    import doctest
    doctest.testmod()
