#!/usr/bin/env python3

import os, re, sqlite3
from bs4 import BeautifulSoup, NavigableString, Tag
import sys
import os.path

res_dir = sys.argv[1]
doc_id = "automake"

db = sqlite3.connect("{}/docSet.dsidx".format(res_dir))
cur = db.cursor()

try: cur.execute('DROP TABLE searchIndex;')
except: pass
cur.execute('CREATE TABLE searchIndex(id INTEGER PRIMARY KEY, name TEXT, type TEXT, path TEXT);')
cur.execute('CREATE UNIQUE INDEX anchor ON searchIndex (name, type, path);')

pages = ["Macro", "Variable"]

sql = 'INSERT OR IGNORE INTO searchIndex(name, type, path) VALUES (?,?,?)'

doc_dir = "{}/Documents/{}".format(res_dir, doc_id)

for page in pages:
  soup = BeautifulSoup(open("{}/{}-Index.html".format(doc_dir, page)))
  for tag in soup.find_all('a'):
    for ct in tag.contents:
      if ct.name == "code":
        path = doc_id + "/" + tag['href']
        if len(ct.contents) == 1:
          obj_name = ct.string
        else:
          obj_name = ct.contents[0].string + ct.contents[1].string
        print("{}:{}->{}".format(page, obj_name, tag['href']))
        cur.execute(sql, (obj_name, page, path))

soup = BeautifulSoup(open("{}/index.html".format(doc_dir)))
for tag in soup.find_all('tr'):
  for td in tag.find_all('td'):
    for a in td.find_all('a'):
      print(a['href'], a.string)
      cur.execute(sql, (a.string, "Guide", doc_id + "/" + a['href']))

db.commit()
db.close()
