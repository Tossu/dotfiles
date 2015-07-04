#!/usr/bin/env python
# -*- coding: utf-8 -*-

from multiprocessing import Pool
import requests
from bs4 import BeautifulSoup
import re

def get_manga_ids(mangas):
    url = "http://www.mangareader.net/alphabetical"
    soup = BeautifulSoup(requests.get(url).content)
    links = soup.findAll('a', href=True, text=mangas)
    parser = re.compile("^\/(\d+)\/.+\.html")
    for link in links:
        yield (int(parser.match(link['href']).group(1)), link.getText())

def get_latest(manga):
    slug = re.sub(r'\W+', '-', manga[1].lower())
    url = "http://www.mangareader.net/%d/%s.html" \
            % (manga[0], slug)
    soup = BeautifulSoup(requests.get(url).content)
    latest = soup.find('div', {'id': 'latestchapters'}) \
            .find_all('a')[0]
    m = re.search("^\/.+\/(\d+)$", str(latest['href']))
    return (manga[1], int(m.group(1)))

if __name__ == "__main__":
    mangas = [
        "One Piece",
    ]

    pool = Pool()
    versions = pool.map(get_latest, get_manga_ids(mangas))
    pool.close()
    pool.join()

    for manga in versions:
        print("%s [%d]"  % (manga[0], manga[1]))
