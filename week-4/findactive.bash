#! /bin/bash

> activehosts.txt

while IFS= read -r line
do
    ping -c 1 -W 1 "$line"
    if [ $? -eq 0 ]
    then
        echo "$line" >> activehosts.txt
    fi
done < possibleips.txt
