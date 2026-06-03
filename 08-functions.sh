#!/bin/bash
validate(){
    if [ $1 -ne 0 ]
    then
      echo "$2 is failure"
      exit 1
    else
      echo "$2 is success"
    fi
}

dnf install nginxxxxx -y
validate $? "installing nginxxx"