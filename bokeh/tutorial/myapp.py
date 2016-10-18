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
l = plot.line(x=[], y=[])
ds = l.data_source


def callback():
    global i, ds
    y = [i] * n
    ds.data = {'x': x, 'y': y}
    i += 1


def callback_animate():
    global i
    while i < 90:
        callback()
        sleep(0.02)


# add a button widget and conploture with the call back
button = Button(label="Animate")
button.on_click(callback_animate)

# put the button and plot in a layout and add to the document
curdoc().add_root(column(button, plot))
