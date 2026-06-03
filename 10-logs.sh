#!/bin/bash
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
userid=$(id -u)
mkdir -p /var/log/shell-script-logs
log_folder="/var/log/shell-script-logs"
name=$(echo $0 |cut -d "." -f1)
log-file="$log_folder/$name.log"

if [ $userid -ne 0 ]
then 
  echo "$R Error: $N you should run this script with root access" &>>$log-file
  exit 1
else
  echo "$G you are running with root access $N" &>>$log-file
fi