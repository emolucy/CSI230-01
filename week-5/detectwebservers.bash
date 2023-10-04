#! /bin/bash

> webservers.txt

while IFS= read -r line
do
    code=$(curl --head -s -o /dev/null -w "%{http_code}" -m 1 "$line")

    if [ "$code" -eq 200 ]
    then
        echo "$line" >> webservers.txt
    fi
done < activehosts.txt
