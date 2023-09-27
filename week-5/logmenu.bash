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

# go through clientIPs.txt and count how many times each ip has
# accessed the website within the last day
visitors () {
    while IFS= read -r line
    do
        cat /var/log/apache2/access.log |
            egrep "$line\s-\s-\s\[$(date +"%d/%b/%Y")" |
            cut -d ' ' -f 1
    done < clientIPs.txt
}

# go through client
badClients () {
    date=$(date +%d/%b/%Y:%H)

    while IFS= read -r line
    do
        regex="$line - - \[$date.*HTTP.*(404|403|400)"

        cat /var/log/apache2/access.log |
            egrep "$regex"
            cut -d ' ' -f 1 |
            sort |
            uniq -c

            # TODO: show only count higher than 3
    done < clientIPs.txt
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
            visitors | uniq -c;;
        2)
            visitors | uniq;;
        3)
            badClients;;
        7)
            echo "Goodbye!"
            break;;
        *)
            echo "Invalid option";;
    esac

    echo # newline

    read -p "Press enter to continue..."
done
