import json

with open("googlemap_key.txt") as f:
    API_KEY = f.read().rstrip()

# Following
# http://bokeh.pydata.org/en/latest/docs/user_guide/geo.html


from bokeh.io import output_file, show
from bokeh.models import (
  GMapPlot, GMapOptions, ColumnDataSource, Circle, DataRange1d, PanTool, WheelZoomTool, BoxSelectTool
)

map_options = GMapOptions(lat=38.5, lng=-121.5, map_type="roadmap", zoom=10)

plot = GMapPlot(
    x_range=DataRange1d(), y_range=DataRange1d(), map_options=map_options
)
#plot.title.text = "Austin"

# For GMaps to function, Google requires you obtain and enable an API key:
#
#     https://developers.google.com/maps/documentation/javascript/get-api-key
#
# Replace the value below with your personal API key:
plot.api_key = API_KEY


with open("incidents.json") as f:
    incidents = json.load(f)

pts = [x['point']['coordinates'] for x in incidents]

source = ColumnDataSource(
    data=dict(
        lat=[x[0] for x in pts],
        lon=[x[1] for x in pts],
    )
)

circle = Circle(x="lon", y="lat", size=15, fill_color="blue", fill_alpha=0.8, line_color=None)
plot.add_glyph(source, circle)

plot.plot_height = 700
plot.plot_width = 700
#plot.add_tools(PanTool(), WheelZoomTool())

plot.min_border = 0


output_file("gmap_plot.html")
show(plot)
