# myapp.py

from time import sleep

from bokeh.layouts import column
from bokeh.models import Button
from bokeh.plotting import figure, curdoc, show


plot = figure(x_range=(0, 100), y_range=(0, 100), toolbar_location=None)

x = list(range(100))
n = len(x)

i = 0

# No data yet
ds = plot.line(x=[], y=[]).data_source


def frame(i):
    """
    A single frame
    """
    y = [i] * n
    plot.title.text = "Now we're on: " + str(i)
    # Need to update the whole dict like this
    ds.data = {'x': x, 'y': y}


def animate():
    global i
    while i < 90:
        frame(i)
        sleep(0.02)
        i += 1


button = Button(label="Animate")
button.on_click(animate)

# put the button and plot in a layout and add to the document
curdoc().add_root(column(button, plot))
