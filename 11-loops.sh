#!/bin/bash
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
userid=$(id -u)
mkdir -p /var/log/shell-script-logs
log_folder="/var/log/shell-script-logs"
name=$(echo $0 |cut -d "." -f1)
LOG_FILE="$log_folder/$name.log"
PACKAGES=(mysql nginx python)
if [ $userid -ne 0 ]
then 
  echo -e "$R Error: $N you should run this script with root access" | tee -a $LOG_FILE
  exit 1
else
  echo -e "$G you are running with root access $N" | tee -a $LOG_FILE
fi
validate(){
    if [ $1 -ne 0 ]
    then
      echo -e "$2 is  $R failure $N" | tee -a $LOG_FILE
      exit 1
    else
      echo -e "$2 is $G success $N" | tee -a $LOG_FILE
    fi
}
for package in ${PACKAGES[@]}
do
  dnf list installed $package &>> $LOG_FILE
  if [ $? -ne 0 ]
  then 
    dnf install $package -y &>> $LOG_FILE
    validate $? "installing $package"
  else
    echo -e "$package is already installed...nothing to do... $Y SKIPPING $N"
  fi
done

