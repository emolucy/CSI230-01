#! /bin/bash

bin="$1"

dec=""

for i in {0..3}
do
    dec+=$((2#${bin:($i*8):8}))
    if [ $i -ne 3 ]
    then
        dec+="."
    fi
done

echo "$dec"
