#!/bin/zsh

# dmenu command
alias dmenu="dmenu -i -fn 'xft:Terminus:pixelsize=8' -nb '#000000' -nf '#FFFFFF' -sb '#0066ff'"

# hosts for rdesktop
hosts=( merry-winxp.eng.idirect.net bldwinvc7.eng.idirect.net )
# declare menu as associative array
typeset -A menu
menu=(
      firefox      firefox
      eclipse      eclipse
      rdesktop     'rdesktop -K -r sound:local $(dmenu <<< ${(F)hosts})'
      rdesktop-fs  'rdesktop -g workarea -K -r sound:local $(dmenu <<< ${(F)hosts})'
     )
# menu order (optional, default is alphabetic order of menu keys)
menu_order=( firefox eclipse rdesktop rdesktop-fs )
# default ordering if menu_order isn't defined
menu_items=(${menu_order:-${(o)${(k)menu}}})

# display and run menu
exe=$(dmenu <<< ${(F)menu_items} ) && eval "exec ${menu[$exe]}"
