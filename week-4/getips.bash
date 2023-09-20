cat /var/log/apache2/access.log | 
    grep $(date +"%d/%b/%Y") |
    grep -o -E "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}" | 
    sort | 
    uniq -c
