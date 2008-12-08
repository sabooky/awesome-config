#!/bin/sh
exe=$(cat <<EOF | dmenu -i -fn 'xft:Terminus:pixelsize=8' \
-nb '#000000' -nf '#FFFFFF' -sb '#0066ff'
firefox
EOF) && eval "exec $exe"
