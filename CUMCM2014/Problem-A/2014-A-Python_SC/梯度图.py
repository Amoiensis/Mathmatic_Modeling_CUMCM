# -*- coding: utf-8 -*-
"""
---------------------------------------------
    File Name:          粗避障
    Desciption:         
    Author:             fanzhiwei
    date:               2019/9/5 9:58
---------------------------------------------
    Change Activity:    2019/9/5 9:58
---------------------------------------------
"""

import numpy as np
import math
import matplotlib.pyplot as plt
from scipy import ndimage
from PIL import Image


LongRangeScanRaw = plt.imread("./1.tif")
ShortRangeScanRaw = plt.imread("./2.tif")
ShortRangeScanMean = ndimage.median_filter(ShortRangeScanRaw, 10)
LongRangeScanMean = ndimage.median_filter(LongRangeScanRaw, 10)

SizeLong = math.sqrt(LongRangeScanRaw.size)
SizeShort = math.sqrt(ShortRangeScanRaw.size)

def ToBinary(map_data):
    mean = map_data.mean()
    diff = np.abs(map_data - mean)
    variance = math.sqrt(map_data.var()) * 0.7

    x, y = np.gradient(map_data)
    graded_map = np.hypot(x, y)        # 梯度图

    mean_graded = graded_map.mean()
    diff_graded = np.abs(graded_map - 0)
    variance_graded = math.sqrt(graded_map.var()) * 0.84


    low_value_indices = diff < variance
    high_value_indices = diff >= variance
    map_data[low_value_indices] = 0
    map_data[high_value_indices] = 255

    low_value_indices = diff_graded < variance_graded
    high_value_indices = diff_graded >= variance_graded
#    map_data[low_value_indices] = 0
    map_data[high_value_indices] = 255

    return map_data


if __name__ == "__main__":
    Longimage = Image.fromarray(ToBinary(LongRangeScanMean))
    Shortimage = Image.fromarray(ToBinary(ShortRangeScanMean))
    Longimage.save("new_1.bmp")
    Shortimage.save("new_2.bmp")