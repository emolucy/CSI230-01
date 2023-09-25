#! /bin/bash

ip=$(bash convip2bin.bash "$1")
pref=$2
first=$(cut -c 1-"$pref" <<< "$ip")

make_full_ip_24() {
    echo "$1$(echo "obase=2; $2" | bc | awk '{printf "%08s", $0}')";
}

make_full_ip_16() {
    echo "$1$(echo "obase=2; $2" | bc | awk '{printf "%08s", $0}')$(echo "obase=2; $3" | bc | awk '{printf "%08s", $0}')";
}

if [[ "$pref" -eq 24 ]]
then
    for i in {1..254}
    do
        if [[ $i -eq 1 ]] # overwrite existing file first
        then
            make_full_ip_24 $first $i > ips.txt
        else
            make_full_ip_24 $first $i >> ips.txt
        fi
    done
fi

if [[ "$pref" -eq 16 ]]
then
    for i in {0..255}
    do
        for j in {0..255}
        do
            if ! { [ $i -eq 0 ] && [ $j -eq 0 ] || [ $i -eq 255 ] && [ $j -eq 255 ]; }
            then
                if [[ $i -eq 1 ]] && [[ $j -eq 1 ]] # overwrite existing file first
                then
                    make_full_ip_16 $first $i $j > ips.txt
                else
                    make_full_ip_16 $first $i $j >> ips.txt
                fi
            fi
        done
    done
fi
