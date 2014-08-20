'''
Basically, I want to load an image and then for each x,y coordinate know the rgb numbers.

e.g.a filename IMG_4843.JPG

then as output I would like a flat file of the form ....

x | y | r | g| b
0|0|149|95|31
...
1208|725|137|49|1

where x and y are the pixel coordinate and r,g,b is the, well you know, lol ...

the field separator doesn't have to be a pipe.
'''

import sys

import pandas as pd
from skimage.io import imread

image = imread('python_logo.png')

red = image[:,:,0]

rdf = pd.DataFrame(red)
rdf['x'] = rdf.index

rdf = pd.melt(rdf, id_vars=['x'], var_name='y')

