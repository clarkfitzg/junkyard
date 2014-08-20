'''
Command line usage:

    $ python rgb_convert.py catpics.png

This will create the file catpics.csv containing rows as below:

    x, y, red, green, blue

where x, y are cartesian coordinates for the pixels.
'''

from functools import reduce

import pandas as pd
from skimage.io import imread


def melt_2d(value_name, array):
    '''
    melts a 2d numpy array to record x and y coordinates
    '''
    df = pd.DataFrame(array)
    df['x'] = df.index

    return pd.melt(df, id_vars=['x'], var_name='y', value_name=value_name)


def png_to_csv(image_name):
    '''
    Creates the CSV file as described in the module docstring
    '''
    base_name = image_name.split('.')[0]
    image = imread(image_name)

    color_index = {'red': 0, 'green': 1, 'blue': 2}

    rgb_dict = {key: melt_2d(key, image[:,:,value]) 
                for key, value in color_index.items()}

    rgb = reduce(pd.merge, rgb_dict.values())
    rgb.to_csv(base_name + '.csv', index=False)


if __name__ == '__main__':

    import sys
    png_to_csv(sys.argv[1])
