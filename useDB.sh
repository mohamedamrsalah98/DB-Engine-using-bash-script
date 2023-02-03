#!/bin/bash


############## Connect To Database ################

read -p "Enter the name of database you want to connect :  " DBName
export $DBName 

 if [ -z $DBName ] || [ "${DBName//[!0-9]}" != "" ] || [[ $DBName =~ ['!@#$%^&*()_+'] ]]
 then
 clear
 echo "#################"
 echo "invalid input (empty) (number) (special character)"
 source useDB.sh
 else
if [[ -d "$DBName" ]] 
then
   cd $DBName
   clear 
   echo "Welcome to $DBName database"
   cd ..
source tableInfo.sh

else
clear
echo "It's not exists!"
source useDB.sh


	select val in "Re-enter name of Database" "Create one" "Back to MENU" "Exit"
	do
		case $val in
            "Re-enter name of Database")
            clear ; . useDB.sh ; clear ; break
            ;;
             "Create one")
            clear ; . createDB.sh  ; break
            ;;
			 "Back to MENU")
            clear ; . Menu.sh ; clear ; break
            ;;
        
            "Exit")
            clear ; exit
            ;;
			* ) echo "Invalid Choice"
		esac
	done
fi
fi