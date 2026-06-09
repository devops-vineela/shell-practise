#!/bin/bash
userid=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
LOGS_FOLDER="/var/log/roboshop-logs"
SCRIPT_NAME=$(echo $0 |cut -d "." -f1)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"
mkdir -p $LOGS_FOLDER
# checks the user has root priviliges or not
check_root(){
if [ $userid -ne 0 ]
then 
  echo -e "$R Error:: you should run this script with root access $N" | tee -a $LOG_FILE
  exit 1
else
  echo -e "$G you are running with root access $N" | tee -a $LOG_FILE
fi
}
check_root
VALIDATE(){
    if [ $1 -ne 0 ]
    then
      echo  -e "$2 is  $R FAILURE $N" | tee -a $LOG_FILE
      exit 1
    else
      echo -e "$2 is $G SUCCESS $N" |tee -a $LOG_FILE
    fi
}


SOURCE_DIR=$1
DESTINATION_DIR=$2
DAYS=${3:-14}

USAGE(){
    echo -e " $R USAGE: $N sh 12-backup.sh <SOURCE_DIR> <DESTINATION_DIR> [DAYS(Optional, default: 14)]"
    exit 1
}

if [ $# -lt 2 ]
then
  USAGE
fi

if [ ! -d $SOURCE_DIR ] 
then 
  echo "Source Directory $SOURCE_DIR does not exist. Please check"
  exit 1
fi

if [ ! -d $DESTINATION_DIR ]
then 
  echo "Destination Directory $DESTINATION_DIR does not exist. Please check"
  exit 1
fi

files=$(find $SOURCE_DIR -name "*.log" -mtime +$DAYS)
if [ -z $files ]
then
  echo -e "No files older than $DAYS days found in $SOURCE_DIR. Nothing to backup or delete....$Y SKIPPING $N" | tee -a $LOG_FILE
else 
  echo -e "files are going to zip......: $files" | tee -a $LOG_FILE
  timestamp=$(date +%F-%H-%M-%S)
  ZIP_FILE="$DESTINATION_DIR/backup-$timestamp.zip"
  echo "$files" | zip -@ $ZIP_FILE
 
fi
if [-f $ZIP_FILE ]
then
 echo -e "Zip file created $G successfully  $N" | tee -a $LOG_FILE
    while IFS=read -r line
    do
    rm -rf $files
    done <<< $files
    echo -e "$G files older than $DAYS days are deleted from $SOURCE_DIR $N" | tee -a $LOG_FILE
fi




