#!/usr/bin/bash
# This script must be on DB

pid=/var/run/mail2root.pid
backup=/local/backups
max_num=10
max_size=10000

while true
do
echo $$ > ${pid}

num=$(ls -l ${backup} | wc -l)
size=$(du -b ${backup} | cut -f1)

if [ ${num} -gt ${max_num} ]
then
	echo "There are ${num} files in ${backup}" | mail -s "ALARM! There are too mach files in backup directory" root@localhost
fi

if [ ${size} -gt ${max_size} ]
then
	echo "There are ${size} bytes in ${backup}" | mail -s "ALARM! There is too mach space spended in backup directory" root@localhost
fi

sleep 666

done

# There is no escape from the loop by the way (((-;
