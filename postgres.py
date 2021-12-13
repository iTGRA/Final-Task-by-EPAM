#!/usr/bin/python3
from datetime import datetime
import psycopg2

current_time = datetime.now()

conn = psycopg2.connect(
    host="192.168.56.22",
    database="anton",
    user="anton",
    password="anton")
if conn:
    print ("Connected Successfully")
else:
    print ("Connection Not Established")
    breakpoint

cur = conn.cursor()
print('Postgres database version:')
cur.execute('SELECT version()')
db_version = cur.fetchone()
print(db_version)

cur.execute(
    'select magazines.name, article_types.type, author.author from magazines, article_types, author, "articles" where articles.magazines_id = magazines.id and articles.article_type_id = article_types.id and articles.author_id = author.id')
print(f"There are {cur.rowcount} rows in table")
row = cur.fetchone()
articles = []

while row is not None:
    articles.append(row)
    row = cur.fetchone()

head_html = '''
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta content="text/html; charset=UTF-8" http-equiv="content-type">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<title>Final Task for EPAM School © iTGRA</title></head>
<style>table, th, td {border:1px solid black;}</style>
<body>
<center>
<br><h3>Here are the following articles in our magazines</h3><br>
<table class="table table-dark table-hover">
<tr><td><center><b>Magazine</b></center></td>
<td><center><b>Type</b></center></td>
<td><center><b>Author</b></center></td></b><br>'''

foot_html = str(f"</table></center><p><p><p align=left> Valid for: {current_time}</p></body></html>")

with open('/var/www/html/articles.html', 'w') as file:
    file.write(head_html)
    for line in articles:
        file.write("<tr>")
        file.write("\n")
        for x in line:
            text = "<th><center>"+str(x)+"</center></th>"+"\n"
            file.write(text)
        file.write("</tr>")
        file.write("\n")
    file.write(foot_html)

if conn:
        cursor.close()
        conn.close()
        print("Postgres connection is closed.")

