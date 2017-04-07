
from bokeh.util.browser import view
from bokeh.document import Document
from bokeh.embed import file_html
from bokeh.models.glyphs import Patch
from bokeh.models import (
     GMapPlot, Range1d, ColumnDataSource, GMapOptions, WheelZoomTool, PanTool
)
from bokeh.resources import INLINE

from bokeh.sampledata.us_states import data as states

with open("googlemap_key.txt") as f:
    API_KEY = f.read().rstrip()

map_options = GMapOptions(lat=39.5501, lng=-105.7821, map_type="roadmap", zoom=6)

plot = GMapPlot(x_range=Range1d(), y_range=Range1d(), map_options=map_options, api_key=API_KEY)

source = ColumnDataSource(data=dict(x=states['CO']["lons"], y=states['CO']["lats"]))

patch = Patch(x="x", y="y", line_color="red", fill_color=None)
plot.add_glyph(source, patch)

doc = Document()
doc.add_root(plot)

plot.add_tools(WheelZoomTool(), PanTool())

filename = "maps.html"
with open(filename, "w") as f:
    f.write(file_html(doc, INLINE, "Google Maps Example"))
view(filename)
