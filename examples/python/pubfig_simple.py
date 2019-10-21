import numpy as np
import matplotlib.pyplot as plt

from examples.python import data
from pubfig import set_figure_handle, set_axes_handle, set_axes_handles

# Import data
(x1, y1) = data.data_1()
(x2, y2) = data.data_2()

# Generate simple figure
fig, ax = plt.subplots()
ax.scatter(x1, y1, s=10, c=[0.2, 0.4, 0.6, 1])
ax.plot(x2, y2, lw=1, c=[0.7, 0.3, 0.3, 1])
ax.set_xlim(-10, 10)
ax.set_ylim(-10, 10)
ax.set_xlabel('Var 1')
ax.set_ylabel('Var 2')
ax.set_title('My arbitary correlation')

fig = set_figure_handle(fig, 5, 5)
ax = set_axes_handle(ax)

plt.savefig('pubfig_simple.png')
plt.savefig('pubfig_simple.pdf')