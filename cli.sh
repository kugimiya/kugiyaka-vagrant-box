#!/bin/bash


if [ -n "$1" ]
then

if [ "$1" = "start" ]
then
echo "Start up..."
vagrant up; vagrant rsync-auto
fi

if [ "$1" = "flush" ]
then
echo "Flushing..."
vagrant destroy -f; ./cli.sh start
fi

else
echo "No action. Available actions: start, flush";
exit 1;
fi
