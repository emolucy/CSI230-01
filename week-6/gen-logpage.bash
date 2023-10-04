#! /bin/bash

bash getlogs.bash

> index.html

echo "
<html>
    <head>
        <title>Apache Log</title>
        <style>
            table {
                width: 100%;
                border-collapse: collapse;
                font-family: arial, sans-serif;
            }
            th, td {
                border: 1px solid lightgrey;
                padding: 12px;
                text-align: left;
            }
            tr:nth-child(even) {
                background-color: #e3e3e3;
            }
        </style>
    </head>
    <body>
        <table>
" >> index.html

echo "
    <tr>
        <th>IP Address</th>
        <th>Time</th>
        <th>Requested Page</th>
        <th>UserAgent</th>
    </tr>
" >> index.html

while IFS= read line
do
    echo "$line"

    ip=$(echo "$line" | cut -d ' ' -f 1)
    date=$(echo "$line" | grep -oE "[0-9]{2}/[A-Z][a-z]{2}/[0-9]{4}")
    time=$(echo "$line" | grep -oE "[0-9]{2}:[0-9]{2}:[0-9]{2}")
    page=$(echo "$line" | grep -oE "\"[A-Z]* /[a-z]*\.*[a-z]*?" | grep -oE "/.*")
    useragent=$(echo "$line" | cut -d ' ' -f 12 | tr -d '"')

    echo "
    <tr>
        <td>$ip</td>
        <td>Accessed at $time on $date</td>
        <td>$page</td>
        <td>$useragent</td>
    </tr>
    " >> index.html


done < logs.txt



echo "
        </table>
    </body>
</html>" >> index.html

cp index.html /var/www/html/index.html
