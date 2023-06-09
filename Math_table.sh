#!/bin/bash

echo "===================== MATH TABLE =====================" 
echo ""

# Initiate loop to check the correctness of user input, use a regular expression
while true
do
  # The "read" command is used to read user input and store it in a variable.
  # The "-p" option allows to specify the prompt that will be displayed before user input.
  read -p "Enter a number between 1 and 15: " operand

  # Using regex and grep -q (silent mode)
  if echo "$operand" | grep -q "^[0-9]\+$" && (( operand <= 15 )) && (( operand > 0 )); then
    break
  else   
    echo "You entered the wrong operand."
  fi
done

echo ""

# Initiate loops to check the correctness of user input, use a for-loop to make comparison
operators=("+" "-" "*" "/" "^")

while true
do
  read -p "Enter the operation, please (+, -, *, /, ^): " operator
  if echo "$operator" | grep -q "^[+*^/\-]\+$"; then
    break
  else
    echo "You entered the wrong operator."
  fi
done

echo ""

# The "echo" command is used to display text on the screen
echo "Here is your math table for $operand $operator "
echo ""

# A function that performs math operations which Bash does without additional packages
# Used as a teaching example
do_simple_math() {
  second_operand=1

  while [ $second_operand -le 15 ]
  do
  echo "$operand" "$operator" "$second_operand" = $(("$operand" "$operator" "$second_operand"))
  # Incrementing the second operand
  ((second_operand ++))
  done
}

# A function that performs division using bc package
# Used separately, because the output of fractions requires a different formatting
use_bc_for_division() {
  second_operand=1

  while [ $second_operand -le 15 ]
  do
  result=$(echo "scale=1; $operand $operator $second_operand" | bc)
  # printf creates formatted output
  echo $operand $operator $second_operand = $(printf "%.1f\n" $result)
  ((second_operand ++))
  done
}

# A function that performs exponentiation using bc package
# Used separately because the use of "^" in the Bash environment leads to an unexpected result
use_bc_for_exponentiation() {
  second_operand=1

  while [ $second_operand -le 15 ]
  do
  result=$(echo "$operand $operator $second_operand" | bc)
  echo $operand $operator $second_operand = $result
  ((second_operand ++))
  done
}

# The main part of the script that selects the desired action
if echo "$operator" | grep -q "^[+*\-]\+$"; then
  do_simple_math
elif echo "$operator" | grep -q "^[\/]\+$"; then
  use_bc_for_division
else
  use_bc_for_exponentiation
fi

echo ""

# This command delays the closing of the terminal window until the user presses the Enter
read -p "Press Enter to exit"
