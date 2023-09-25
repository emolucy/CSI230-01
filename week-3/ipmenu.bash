#! /bin/bash

while true;
do
    echo # make a newline
    echo "Please select an option:"
    echo "1-Get my IP address"
    echo "2-Get my IP address in binary"
    echo "3-Get my network mask in binary"
    echo "4-Get my network address in binary"
    echo "5-Convert a binary to IP address"
    echo "6-Quit"

    read -p "Enter your choice: " choice

    echo # make a newline

    case "$choice" in
        1)
            echo "Your IP address: $(bash myip.bash)";;
        2)
            echo "Your IP address in binary: $(bash myipbinary.bash)";;
        3)
            echo "Your network mask in binary: $(bash mymaskbinary.bash)";;
        4)
            echo "Your network address in binary: $(bash mynetworkbinary.bash)";;
        5)
            read -p "Enter 32 character binary IP address: " ip
            echo # make a newline

            if [ ${#ip} -eq 32 ]
            then
                echo "IP address: $(bash convbin2ip.bash $ip)"
            else
                echo "Invalid length."
            fi;;
        6)
            echo "Goodbye!"
            break;;
        *)
            echo "Invalid option";;
    esac

    read -p "Press enter to continue..."
done
