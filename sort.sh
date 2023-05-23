#!/bin/bash

# environment 
WORKDIR1=/home/$user/Desktop/template
WORKDIR2=/home/$user/Share/template

#test
if [ -e $WORKDIR1.csv ]
	then WORKDIR=$WORKDIR1 
elif [ -e $WORKDIR2.csv ]
	then WORKDIR=$WORKDIR2
else echo "soooooo"
fi
echo $WORKDIR
cat $WORKDIR.csv | 
sed '/Фамилия/d' |
sed '/^[^,]*,[^,]*,$/d' |
awk -F',' '!/^#/{print $3,$4,$2}/^#/' |
sed 's/\\*\\*:\\*\\* - //g' |
sed 's/ - \\*\\*:\\*\\   *//g' |
sort > $WORKDIR.txt
