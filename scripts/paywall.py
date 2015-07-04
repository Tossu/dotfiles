#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import requests
from bs4 import BeautifulSoup
from urllib import parse

def get_share_url(url):
    r = requests.get(url)
    soup = BeautifulSoup(r.content)
    twitter_url = soup.find('a', {'class': 'article-tweet'}).get('href')
    url_decode = str(parse.unquote(twitter_url).encode('utf-8'))
    return str(parse.parse_qs(url_decode)['url'][0])

if __name__ == "__main__":
    if (len(sys.argv) == 2):
        print(get_share_url(sys.argv[1]))
        sys.exit(0)
    print("Usage: python paywall.py [url]");
    sys.exit(1)
