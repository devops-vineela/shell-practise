#!/bin/bash
echo "Enter a number"
read -s number
if [ $number -lt 100 ]
then
  echo "number is less than 100"
else 
  echo "number is not leass than 100"
fi