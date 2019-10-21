import numpy as np


def data_1():

    x1 = np.arange(-7, 7, 0.25)
    y1 = 0.5 * x1 + np.random.normal(0, 1, (len(x1),))

    return x1, y1


def data_2():

    x2 = np.arange(-9, 9, 1)
    y2 = 0.5 * x2

    return x2, y2

