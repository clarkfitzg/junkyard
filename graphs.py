import matplotlib.pyplot as plt
import networkx as nx


class PlotGraph(nx.Graph):

    def __repr__(self):
        return "Hey dude."

    def matrix(self):
        return nx.to_scipy_sparse_matrix(self)



g = nx.random_lobster(10, 0.3, 0.2)

def attach_eigen(g):
    g.eigen = "TODO: compute these"

attach_eigen(g)


g2 = PlotGraph(g)

m = g2.matrix()
