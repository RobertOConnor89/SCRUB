# -*- coding: utf-8 -*-
"""
Created on Mon Dec  4 14:34:10 2017

web scraping bot made with beautiful soup and python

@author: useth
"""

import bs4
from urllib.request import urlopen as ureq
from bs4 import BeautifulSoup as soup
my_url = "http://allrecipes.com/recipe/10813/best-chocolate-chip-cookies/"
uclient = ureq(my_url)
page_html = uclient.read()
uclient.close()
page_soup = soup(page_html, "html.parser")

