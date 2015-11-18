'''
iterable_cards.py

This script demonstrates core data structures and iterables in Python 3
using basic statistical concepts. Pay attention to what lazy evaluation
does for the program's memory usage.

In this simple card game each card has a value.
A player draws several cards without replacement and sums their values
to determine their final score.

Task:
Understand the probability distribution for scores from this card game.

Approach 1: Convert directly to DataFrame

    dist = pd.Series(list(allhands()))
    dist.hist(bins=100)

Approach 2: Reduce operation
This has the advantage of being able to run an arbitrarily large data.
For example, the line below produces and scores 750 million hands.

    score_counts = collections.Counter(allhands(handsize=8))
'''

import itertools


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

    >>> small = list(allhands(handsize=2))
    >>> max(small)
    100
    >>> len(small)
    1326
    >>> from scipy.misc import comb
    >>> comb(N=52, k=2, exact=True)
    1326

    Use `scipy.misc.comb` to verify expectations.
    Here 52 choose 2 hands are generated and scored.
    '''
    # The cartesian product of cards and suits produces a deck of cards.
    deck = itertools.product(cards.keys(), suits)

    # This iterator produces all possible combinations of 5 card hands.
    sample_space = itertools.combinations(deck, handsize)

    # Apply the random variable to every element in the sample space.
    return map(random_variable, sample_space)


if __name__ == '__main__':
    import doctest
    doctest.testmod()
