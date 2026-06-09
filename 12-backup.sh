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
script_dir=$PWD

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
if [ ! -d $SOURCE_DIR ] 
then 
  echo "Source Directory $SOURCE_DIR does not exist. Please check"
fi

if [ ! -d $DESTINATION_DIR ]
then 
  echo "Destination Directory $DESTINATION_DIR does not exist. Please check"
fi

files=$(find $SOURCE_DIR -name "*.log" -mtime +$DAYS)

while IFS= read -r filepath
do
  rm -rf $filepath
done <<< $files

echo -e "$G files older than $DAYS days are deleted from $SOURCE_DIR $N" | tee -a $LOG_FILE
