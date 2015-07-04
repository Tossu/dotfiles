#!/usr/bin/env python
# -*- coding: utf-8 -*-

GREEN = '\033[92m'
RED = '\033[91m'
END = '\033[0m'


def color_string(string, color):
    return color + string + END


def print_color(message, color):
    print(color_string(message, color))
