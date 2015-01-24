'''
Simple example
'''

import networkx as nx
import matplotlib.pyplot as plt


# create networkx graph
G = nx.digraph.Graph()

e = [('Clark', 'Yeji'), ('Yeji', 'Jungmin'), 
     ('Clark', 'Yeji'), ('Jake', 'Clark')]

#labels = {1: 'one', 2: 'two', 3: 'three', 4: 'four'}

G.add_edges_from(e)

#pos = nx.shell_layout(G)
#pos = nx.spring_layout(G)

nx.draw_networkx(G, pos,
        node_size=1500, node_color='g',
        alpha=0.3,
        )

#nx.draw_networkx_labels(G, pos, font_size=12)
#label_pos=edge_text_pos)

#plt.show()



'''
# add edges
for edge in graph:
    G.add_edge(edge[0], edge[1])

# draw graph
pos = nx.shell_layout(G)
nx.draw(G, pos)

# show graph
plt.show()

# draw example
graph = [(20, 21),(21, 22),(22, 23), (23, 24),(24, 25), (25, 20)]
draw_graph(graph)
'''
