#!/bin/bash

max_count=3
db_name=articles
files=/local/files
backup=/local/backups
query='SELECT magazines.name, article_types.type, author.author FROM magazines, article_types, author, articles WHERE articles.magazines_id=magazines.id AND articles.article_type_id=article_types.id AND articles.author_id=author.id;'

# Fetching data from SQL into text file.
echo $query | psql -U anton > $files/$db_name.`date +%F`.sql && echo "Export raw data from table '${db_name}' into .sql file"
ls -l $files

num=$(ls -l ${files} | wc -l)

if [ ${num} -gt ${max_count} ]
then
   gzip -9 $files/*.sql
   mv $files/*.gz $backup
   echo "${num} files were moved into ${backup} directory"
   ls -l $backup
else
   echo "No files were moved into ${backup} directory"
fi
