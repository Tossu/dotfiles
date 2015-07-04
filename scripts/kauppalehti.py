#!/usr/bin/env python
# -*- coding: utf-8 -*-

import requests
from bs4 import BeautifulSoup
from color_print import print_color, GREEN, RED
from functools import reduce


def get_stocks(portfolio):
    url = 'http://app.kauppalehti.fi/market/stockexchange'
    r = requests.get(url)
    soup = BeautifulSoup(r.content)
    elements = soup.find('div', {'class': 'stock-list'}).find_all('div',
            {'class': 'stock-item'})

    for element in elements:
        n, c, t, _, v = (str(s.string) for s in element.find_all('span'))
        if n not in portfolio:
            continue

        c = float(c.replace('%', '')) if c != '-' else 0
        v = float(v) if v != '-' else 0

        yield (n,c,v,t)


if __name__ == "__main__":
    portfolio = [
        "Nokia",
        "Nordea Bank",
        "Nokian Renkaat",
        "Raisio V",
        "UPM-Kymmene",
        "F-Secure"
    ]
    offset = reduce(lambda s, v: max(s, len(v)), portfolio, 0)
    for stock in get_stocks(portfolio):
        name, change, value, time = stock

        s = "%%%ss %%5s%%%% %%6s %%5s" % offset
        s = s % (name, change, value, time)
        if 0 < change:
            print_color(s, GREEN)
        else:
            print_color(s, RED)
