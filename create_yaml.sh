#!/bin/bash

SRC_DIR=$1
CONF_PATH=$2

if [ "$1" == "" ] || [ "$2" == "" ]
then
  echo "Please specify the template directory and the conf file. exited."
  exit
fi

DEST_DIR=temp-$(date +%s)
IFS=$'\n' read -d '' -r -a conf < $CONF_PATH

if [ -d "$DEST_DIR" ] 
then
    while true; do
        read -p "$DEST_DIR is already existed. Do you want to continue?(y/n): " yn
        case $yn in
            [Yy]* ) break;;
            [Nn]* ) exit;;
            * ) echo "Please answer yes or no.";;
        esac
    done
fi

mkdir -p $DEST_DIR
for file in $SRC_DIR/*.yaml.template
do
    command="sed"
    for k in ${conf[@]}
    do
      command+=$(echo $k | awk -F '=' '{print " -e \"s/{{"$1"}}/"$2"/g\"" }')
    done
    command+=" $file > $DEST_DIR/$(basename $file | sed 's/.template//')"
    echo $command
    eval $command
done
echo "The files are created!"

