#!/bin/bash


START_MILI=$(date +"%s%3N")
	sleep 10
END_MILI=$(date +"%s%3N")
DIFF_MILI=$(($END_MILI-$START_MILI))


START_SEC=$(date +"%s")
	sleep 10
END_SEC=$(date +"%s")
DIFF_SEC=$(($END_SEC-$START_SEC))


echo "Number of Miliseconds registered"
	echo "$DIFF_MILI"

echo "Number of Secondds registered"
	echo "$DIFF_SEC"
