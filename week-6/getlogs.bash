#! /bin/bash

logs=$(ls -1d /var/log/apache2/* | grep -E "/access.log")

> logs.txt

while read file
do
    cat $file >> logs.txt
done <<< "$logs"
