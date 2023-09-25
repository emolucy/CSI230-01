#! /bin/bash

ip=$(bash convip2bin.bash "$1")
pref=$2
first=$(cut -c 1-"$pref" <<< "$ip")

to_binary() {
    local binary="$(echo "obase=2; $1" | bc)"
    printf "%08d" "$binary"
}

make_full_ip_24() {
    echo "$1$(to_binary $2)"
}

make_full_ip_16() {
    echo "$1$(to_binary $2)$(to_binary $3)";
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
