#!/bin/bash
user=$(id -u)
if [ $user -ne 0 ]
then 
  echo "you should run this script with root access"
  exit 1
else
  echo "you are running with root access"
fi

dnf install mysql -y
if [ $? -ne 0 ]
then
  echo "installing mysql is failure"
else 
  echo "installing mysql is success"
fi
