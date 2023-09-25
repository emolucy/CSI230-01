#! /bin/bash

> possibleips.txt

while IFS= read -r line
do
    bash convbin2ip.bash "$line" >> possibleips.txt
done < ips.txt
