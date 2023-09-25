#! /bin/bash

ip=$(bash myipbinary.bash)
pl=$(bash prefixlength.bash)
mask=$(bash mymaskbinary.bash)

network=""

for i in {0..31}
do
    if [[ "${ip:$i:1}" == "1" && "${mask:$i:1}" == "1" ]]
    then
        network+="1"
    else
        network+="0"
    fi
done

echo "$network"
