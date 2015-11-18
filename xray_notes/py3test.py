from collections import OrderedDict
import xray


x = np.linspace(0, 500)
y = np.logspace(0, 3)
xy = np.dstack(np.meshgrid(x, y))
d_ylog = np.linalg.norm(xy, axis=2)
d_ylog = xray.DataArray(d_ylog, zip(('y', 'x'), (y, x)))

d2 = OrderedDict(zip(('y', 'x'), (y, x)))

d3 = xray.DataArray(d_ylog, (x for x in ('y', 'x')))
