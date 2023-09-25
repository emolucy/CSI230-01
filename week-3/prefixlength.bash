#! /bin/bash

ip=$(bash myfullip.bash | cut -d '/' -f 2)

echo "${ip}"
