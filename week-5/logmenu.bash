#! /bin/bash

# functions

# lists all ips that have accessed my webpage
listIPs () {
    cat /var/log/apache2/access.log |
        grep $(date +"%d/%b/%Y") |
        grep -o -E "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}" |
        sort |
        uniq > clientIPs.txt
}

# go through clientIPs.txt and show each ip that has
# accessed the website within the last day
visitors () {
    while IFS= read -r line
    do
        cat /var/log/apache2/access.log |
            egrep "$line\s-\s-\s\[$(date +"%d/%b/%Y")" |
            cut -d ' ' -f 1 |
            sort
    done < clientIPs.txt
}

# go through client
badClients () {
    date=$(date +%d/%b/%Y:%H)

    while IFS= read -r line
    do
        regex="$line - - \[$date.*HTTP.*(404|403|400)"

        cat /var/log/apache2/access.log |
            egrep "$regex" |
            cut -d ' ' -f 1 |
            sort |
            uniq -c |
            awk '$1 >= 3 {print $2}'

    done < clientIPs.txt > blacklisted.txt
}

# block blacklisted ips
block () {
    iptables -F # reset previous blocks first

    while IFS= read -r line
    do
        iptables -A INPUT -s $line -j DROP &&
            iptables -L INPUT -v -n |
            grep $line
    done < blacklisted.txt
}

resetBlocks () {
    iptables -F && iptables -L INPUT -v -n
}

# show visit histogram
histogram () {
    regex=".* - - \[.*HTTP.*200"

    cat /var/log/apache2/access.log |
        egrep "$regex" |
        grep -oE '[0-9]{2}\/[A-Z][a-z]{2}\/[0-9]{4}' |
        sort |
        uniq -c |
        awk '{print $1 " visits on " $2}'
}

# menu
while true;
do
    echo # make a newline
    echo "Please select an option:"
    echo "[1] Number of visitors"
    echo "[2] Display visitors"
    echo "[3] Show bad visits"
    echo "[4] Block bad visits"
    echo "[5] Reset block rules"
    echo "[6] Show visit histogram"
    echo "[7] Quit"

    read -p "Enter your choice: " choice

    echo # make a newline

    case "$choice" in
        1)
            listIPs && cat clientIPs.txt | sort | uniq | wc -l;;
        2)
            visitors | uniq -c;;
        3)
            badClients && cat blacklisted.txt;;
        4)
            block;;
        5)
            resetBlocks;;
        6)
            histogram;;
        7)
            echo "Goodbye!"
            break;;
        *)
            echo "Invalid option";;
    esac

    echo # newline

    read -p "Press enter to continue..."
done
