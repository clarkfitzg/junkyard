'''
We'd like to do some network analysis of a body of text.

Let's build a graph where the nodes are names and the 
weight of the edge is the number of times that the two names
appear in the same sentence together.
'''

import itertools
import networkx as nx

names = {'Clark', 'Yeji', 'Dongmin'}

edgecounts = itertools.combinations(names, 2)

count = dict(zip(edgecounts, itertools.repeat(0)))


def together(namepair, string):
    '''
    Return True if all elements of names are in string
    '''
    return all(n in string for n in namepair)

paragraph = '''
Clark and Yeji are married. Yeji's cousin is Dongmin.
'''

sentences = paragraph.split('.')

for s in sentences:
    for namepair in count:
        if together(namepair, s):
            count[namepair] += 1

G = nx.Graph()

for key, value in count.items():
    G.add_edge(*key, weight=value)
