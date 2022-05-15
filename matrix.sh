#!/bin/bash
COL=80
ROW=$(tput lines)

drop() { # $1=column ; $2=row to end on ; $3 = drop size (ranges from 5 to 15)
  for ((r=1; r<$2+$3+1; r++)); do
    # if before drop's end point : print lowest char in white
    [ $r -lt $2 ] && printf "\033[$r;$1H\033[0;0m\u004C"
    [ $r -lt $2 ] && printf "\033[$r;$[1 +$1]H\033[0;0m\u004F"
    [ $r -lt $2 ] && printf "\033[$r;$[2 +$1]H\033[0;0m\u0056"
    [ $r -lt $2 ] && printf "\033[$r;$[3 +$1]H\033[0;0m\u0045"
    [ $r -lt $2 ] && printf "\033[$r;$[4 +$1]H\033[0;0m\u0020"
    [ $r -lt $2 ] && printf "\033[$r;$[5 +$1]H\033[0;0m\u0055"

    # if drop's longer than it's size : erase last char
    [ $r -gt $3 ] && printf "\033[$[r-$3];$1H "
    [ $r -gt $3 ] && printf "\033[$[r-$3];$[1 +$1]H "
    [ $r -gt $3 ] && printf "\033[$[r-$3];$[2 +$1]H "
    [ $r -gt $3 ] && printf "\033[$[r-$3];$[3 +$1]H "
    [ $r -gt $3 ] && printf "\033[$[r-$3];$[4 +$1]H "
    [ $r -gt $3 ] && printf "\033[$[r-$3];$[5 +$1]H "

    # wait before moving drop down
    sleep .3
  done
}

# clear screen; hide cursor
printf '\033[2J\033[?25l'

# loop with delay
while sleep 1; do
  # start a drop in background : column; ending row; size
  drop $[RANDOM % COL] $[30] $[1] &
done