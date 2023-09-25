#! /bin/bash

pl=$(bash prefixlength.bash)

submask=""

for i in {1..4}
do
	if ((pl - i * 8 >= 0));
	then
		submask+="11111111"
	else
		submask+="00000000"
	fi
done

echo "${submask}"
