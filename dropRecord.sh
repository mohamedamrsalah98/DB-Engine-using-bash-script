#!/bin/bash
read -p "Enter table name: " table
cd $DBName
while ! [ -f $table  ] || [ -z $table ]
do
   echo "there is no table named $table "
   echo "enter table name again please"
   read table
done
read -p "Enter Your Record will be deleted : " dropRecord
while  [ "${dropRecord//[!0-9]}" == "" ]
do
   echo "record must be a number &please enter your value correct"
   read dropRecord
done
# =========================================================#
   if [[ ` awk -F : '{print $0}' $table | awk -F : '{print $1}' | grep $dropRecord ` ]]
   then
      sed -i "/^$dropRecord/d" $table
   else
        echo "try again please"
        cd ..
        source useTable.sh
        fi
            cd ..
            source useTable.sh
 #=========================================================#
      else
    echo error
    source ../useTable.sh




