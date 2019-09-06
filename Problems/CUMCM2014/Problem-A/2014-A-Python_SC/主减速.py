# -*- coding: utf-8 -*-
"""
---------------------------------------------
    File Name:          lisan_simulator
    Desciption:         
    Author:             fanzhiwei
    date:               2019/9/4 21:12
---------------------------------------------
    Change Activity:    2019/9/4 21:12
---------------------------------------------
"""


import math
import matplotlib.pyplot as plt

yuexin = [0.0, 1752013.0]
t = 0.0001

class Zhujiansu():

    def __init__(self):
        self.x = 0.0
        self.y = 0.0
        self.theta = 0.0
        self.v_x = 1692.7
        self.v_y = 0.0
        self.m = 2400.0
        self.t = 0.0
        self.f = 7500.0
        self.ve = 2940.0
        self.G = 6.67*10**(-11)
        self.M = 7.3477*10**22
        self.v = math.sqrt(self.v_x**2 + self.v_y**2)
        self.x_set = []
        self.y_set = []
        self.t_set = []
        self.theta_set = []
        self.v_set = []
        self.height_set = []

        self.x_set.append(self.x)
        self.y_set.append(self.y)
        self.t_set.append(self.t)
        self.theta_set.append((self.theta-0.18422) * 180 / math.pi)
        self.v_set.append(self.v)
        self.height_set.append(self.get_distance() - 1737013.0)

    def get_a(self):
        beta = math.atan2(yuexin[1]-self.y, self.x-yuexin[0])
        r2 = (yuexin[0] - self.x)**2 + (yuexin[1] - self.y)**2
        mg = self.G * self.M * self.m / r2
        a_x = (self.f * math.cos(self.theta-0.1945) + mg * math.cos(beta)) / self.m
        a_y = (self.f * math.sin(self.theta-0.1945) - mg * math.sin(beta)) / self.m
        return a_x, a_y

    def get_distance(self):
        return math.sqrt((yuexin[0]-self.x)**2 + (yuexin[1]-self.y)**2)

    def update(self):
        self.t = self.t + t
        self.m = self.m - (self.f / self.ve) * t
        a_x, a_y = self.get_a()
        x = self.x + self.v * t * math.cos(self.theta) - 0.5 * a_x * t ** 2
        y = self.y + self.v * t * math.sin(self.theta) - 0.5 * a_y * t ** 2
        self.v_x = self.v * math.cos(self.theta) - a_x * t
        self.v_y = self.v * math.sin(self.theta) - a_y * t
        self.v = math.sqrt(self.v_x**2 + self.v_y**2)
        self.theta = math.atan2(y-self.y, x-self.x)
        self.x = x
        self.y = y

        self.x_set.append(self.x)
        self.y_set.append(self.y)
        self.t_set.append(self.t)
        self.height_set.append(self.get_distance() - 1737013.0)
        self.theta_set.append((self.theta-0.18422) * 180 / math.pi)
        self.v_set.append(self.v)

    def draw(self):
        plt.figure()
        plt.plot(self.t_set, self.height_set)
        plt.show()

if __name__ == "__main__":
    print('start')
    zhujiansu = Zhujiansu()
    while zhujiansu.v > 57.0:
        zhujiansu.update()
    print("time:", zhujiansu.t)
    print("location:", zhujiansu.x, zhujiansu.y)
    print("v:", zhujiansu.v)
    print("v_x:", zhujiansu.v_x)
    print("v_y:", zhujiansu.v_y)
    print("m:", zhujiansu.m)
    print("theta:", zhujiansu.theta)
    print("height:", zhujiansu.get_distance() - 1737013.0)
    zhujiansu.draw()