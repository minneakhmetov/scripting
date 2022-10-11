#!/bin/bash

input_numbers=()
target_numbers=()
step=0

RED_COLOR='\033[0;31m'
GREEN_COLOR='\033[0;32m'
NO_COLOR='\033[0m'
while true
do
	target_number=$(($RANDOM % 10))
  
  input_number=0
  while true
  do
    echo "Please enter number from 0 to 9 (q - quit):"
    read input_string
    if [[ $input_string =~ ^[0-9]{1}$ ]]; then
      input_number=$input_string
      break;
    elif [ $input_string = "q" ]; then
      exit 0
    else
      echo -e "${RED_COLOR}Incorrect input: $input_string${NO_COLOR}"
    fi
  done

  input_numbers+=($input_number)
  target_numbers+=($target_number)

  if [ ${#input_numbers[@]} -eq 11 ]; then
    new_input_numbers=()
    new_target_numbers=()
    for i in {1..10}
    do
      new_target_numbers+=(${target_numbers[$i]})
      new_input_numbers+=(${input_numbers[$i]})
    done
    input_numbers=("${new_input_numbers[@]}")
    target_numbers=("${new_target_numbers[@]}")
    unset new_input_numbers
    unset new_target_numbers
  fi

  echo "Step: $step"
  if [ $input_number -eq $target_number ]; then
      echo "Hit! My number: $target_number"
  else
      echo "Miss! My number: $target_number"
  fi

  hitted_numbers=0
  echo -n "Numbers: "
  for i in "${!input_numbers[@]}"; do
    if [ ${input_numbers[$i]} -eq ${target_numbers[$i]} ]; then
      echo -ne "${GREEN_COLOR}${target_numbers[$i]}${NO_COLOR} "
      hitted_numbers=$((hitted_numbers+=1))
    else
      echo -ne "${RED_COLOR}${target_numbers[$i]}${NO_COLOR} "
    fi
  done
  echo ""
  percentage=$(( $hitted_numbers * 100 / ${#input_numbers[@]} ))
  echo "Hit: $percentage% Miss: $((100 - $percentage))"

  step=$((step+=1))
done



