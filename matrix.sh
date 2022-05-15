#!/bin/bash
COL=80
ROW=$(tput lines)

dropL() { # $1=column ; $2=row to end on ; $3 = drop size (ranges from 5 to 15)
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
    sleep .2
  done
}

dropC() { # $1=column ; $2=row to end on ; $3 = drop size (ranges from 5 to 15)
  for ((r=1; r<$2+$3+1; r++)); do
    # if before drop's end point : print lowest char in white
    [ $r -lt $2 ] && printf "\033[$r;$1H\033[0;31m\u0043"
    [ $r -lt $2 ] && printf "\033[$r;$[1 +$1]H\033[0;33m\u0055"
    [ $r -lt $2 ] && printf "\033[$r;$[2 +$1]H\033[0;32m\u0054"
    [ $r -lt $2 ] && printf "\033[$r;$[3 +$1]H\033[0;34m\u0049"
    [ $r -lt $2 ] && printf "\033[$r;$[4 +$1]H\033[0;35m\u0045"

    # if drop's longer than it's size : erase last char
    [ $r -gt $3 ] && printf "\033[$[r-$3];$1H "
    [ $r -gt $3 ] && printf "\033[$[r-$3];$[1 +$1]H "
    [ $r -gt $3 ] && printf "\033[$[r-$3];$[2 +$1]H "
    [ $r -gt $3 ] && printf "\033[$[r-$3];$[3 +$1]H "
    [ $r -gt $3 ] && printf "\033[$[r-$3];$[4 +$1]H "

    # wait before moving drop down
    sleep .3
  done
}

dropW() { # $1=column ; $2=row to end on ; $3 = drop size (ranges from 5 to 15)
  for ((r=1; r<$2+$3+1; r++)); do
    # if before drop's end point : print lowest char in white
    [ $r -lt $2 ] && printf "\033[$r;$1H\033[0;31m\u003C"
    [ $r -lt $2 ] && printf "\033[$r;$[1 +$1]H\033[0;31m\u0033"

    # if drop's longer than it's size : erase last char
    [ $r -gt $3 ] && printf "\033[$[r-$3];$1H "
    [ $r -gt $3 ] && printf "\033[$[r-$3];$[1 +$1]H "

    # wait before moving drop down
    sleep .5
  done
}

# clear screen; hide cursor
printf '\033[2J\033[?25l'

# loop with delay
while sleep 1; do
  # start a drop in background : column; ending row; size
  NUM=$(shuf -i 0-1 -n 1)
  if [[ $NUM -gt 0 ]]
  then
    dropC $[RANDOM % COL+1] $[30] $[1] &
  else
    dropL $[RANDOM % COL+1] $[30] $[1] &
  fi
  dropW $[RANDOM % COL+1] $[30] $[1] &
  sleep .5
done