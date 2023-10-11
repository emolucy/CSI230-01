#! /bin/bash
account=$(cat usr.txt)

help () {
    echo "usage: Accounts -[d|c]"
    echo
    echo "options:"
    echo "  -d      list disabled accounts"
    echo "  -c      count logins of user"
}

disabled () {
    cat /etc/shadow |
        grep -E ":\*:" |
        grep -Eo "[A-Za-z]*"
}

logins () {
    last -w $account |
        grep $account |
        wc -l
}

if [ ! ${#} -eq 1 ]
then
    help
    exit 1
fi


while getopts ":dc" option
do
    case $option in
        d)
            echo "Disabled accounts:"
            disabled
            echo;;
        c)
            echo "Logins for $account: "
            logins
            echo;;
        \?)
            help;;
    esac
done
