#!/usr/bin/env bash

pathtb=($(echo $* | cut -d "/" -f 7-7))
paths=($(echo $* | cut -d "/" -f 7-7 | cut -d "." -f 3))
patchcheck=($(echo $* | cut -d "/" -f 7-7 | cut -d "." -f 1)) 
if [ "$patchcheck" = "verilog" ]; then
    echo $paths
else
    basename $*
fi
