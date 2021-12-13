#!/bin/bash

IFS=$'\n'

file1="/home/anton/magaz.txt"
for var1 in $(cat $file1)
do
echo "insert into magazines (name) values ('$var1')" | psql -U anton
done

file2="/home/anton/article_type.txt"
for var2 in $(cat $file2)
do
echo "insert into article_types (type) values ('$var2')" | psql -U anton
done

file3="/home/anton/author.txt"
for var3 in $(cat $file3)
do
echo "insert into author (author) values ('$var3')" | psql -U anton
done
