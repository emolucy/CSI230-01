#! /bin/bash

ip="$1"

bin=""

part1=$(echo ${ip} | cut -d '.' -f 1)
part2=$(echo ${ip} | cut -d '.' -f 2)
part3=$(echo ${ip} | cut -d '.' -f 3)
part4=$(echo ${ip} | cut -d '.' -f 4)

bin1=$(echo "obase=2;$part1" | bc)
bin2=$(echo "obase=2;$part2" | bc)
bin3=$(echo "obase=2;$part3" | bc)
bin4=$(echo "obase=2;$part4" | bc)

printf "%08d%08d%08d%08d\n" ${bin1} ${bin2} ${bin3} ${bin4}
