#!/bin/bash

############# Show Table #################


cd $DBName
echo "$DBName Table We Have : "

ls -p

echo "#############################"

cd ..
source tableInfo.sh
