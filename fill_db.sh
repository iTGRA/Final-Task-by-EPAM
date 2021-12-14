#!/bin/bash

IFS=$'\n'
# Filling the "Mazagines" table
file1="/home/anton/magaz.txt"
for var1 in $(cat $file1)
do
echo "insert into magazines (name) values ('$var1')" | psql -U anton
done

# Filling the "Article_type" table
file2="/home/anton/article_type.txt"
for var2 in $(cat $file2)
do
echo "insert into article_types (type) values ('$var2')" | psql -U anton
done

# Filling the "Author" table
file3="/home/anton/author.txt"
for var3 in $(cat $file3)
do
echo "insert into author (author) values ('$var3')" | psql -U anton
done
