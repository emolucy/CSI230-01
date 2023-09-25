#! /bin/bash

ip=$(bash myfullip.bash | cut -d '/' -f 1)

echo "${ip}"
