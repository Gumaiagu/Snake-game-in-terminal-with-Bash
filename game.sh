#!/bin/bash


start() {
  tput smcup
  tput civis
  stty -echo
  clear
}


stop() {
  stty echo
  tput cnorm
  tput rmcup
}


game() {
  lines=$(tput lines)
  cols=$(tput cols)
  total_chars=$(( $lines * $cols - 1 ))

  snake_positions[0]=$((( $lines * $cols - 1 ) / 2 ))
  snake_size=0
  snake_direction=1

  apple_position=$(( $(shuf -i 0-$total_chars -n 1) - 1 ))

  while true; do
    clear

    new_position=0

    case "$snake_direction" in
      "1")
        new_position=$(( ${snake_positions[$snake_size]} - $cols ));;
      "2")
        new_position=$(( ${snake_positions[$snake_size]} + $cols ));;
      "3")
        new_position=$(( ${snake_positions[$snake_size]} + 1 ))
        if [[ $((${snake_positions[$snake_size]}/$cols)) -ne $(($new_position/$cols)) ]]; then
          stop
          echo "You've lost!"
          exit 0
        fi
        ;;
      "4")
        new_position=$(( ${snake_positions[$snake_size]} - 1 ))
        if [[ $((${snake_positions[$snake_size]}/$cols)) -ne $(($new_position/$cols)) ]]; then
          stop
          echo "You've lost!"
          exit 0
        fi
        ;;
    esac

    if [[ ($new_position -lt 0) || ($new_position -gt $total_chars)]]; then
      stop
      echo "You've lost!"
      exit 0
    fi

    if [[ "${snake_positions[${snake_size-1}]}" -eq $apple_position ]]; then
      apple_position=$(( $(shuf -i 0-$total_chars -n 1) - 1 ))
      snake_size=$((snake_size+1))
      if [[ $snake_size -eq $total_chars ]]; then
        stop
        echo "You've won!"
        exit 0
      fi
    else
      temp=0
      while [ $temp -ne ${snake_size} ]; do
        snake_positions[temp]=${snake_positions[temp + 1]}
        if [[ ${snake_positions[temp]} -eq $new_position ]]; then
          stop
          echo "You've lost"
          exit 0
        fi
        temp=$((temp+1))
      done
    fi
    snake_positions[${snake_size}]=$new_position

    chars=""
    for ((i=0; i<$total_chars; i++)); do  # Rendering system
      if [[ $i -eq "${snake_positions[${snake_size}]}" ]]; then
        echo -n "@"
      elif [[ $i -eq $apple_position ]]; then
        echo -n "ç"
      elif [[ " ${snake_positions[@]} " =~ " $i " ]]; then
        echo -n "o"
      else
        echo -n " "
      fi
    done

    read -s -t .1 -n 1 key
    if [[ $key == "q" ]]; then
      stop
      break
    elif [[ $key == $'\e' ]]; then
      read -s -n 2 key
      case "$key" in
          "[A") snake_direction=1;;
          "[B") snake_direction=2;;
          "[C") snake_direction=3;;
          "[D") snake_direction=4;;
      esac
    fi
  done
}


start
game
