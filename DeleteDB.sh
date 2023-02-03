#!bin/bash

################################### Delete Database  ###################################

read -p "Enter the name of database you want to delete :  " DBName

if [[ -d "$DBName" ]]
then
read -p "are You sure Delete $DBName (Enter yes):  " delete
if [ $delete = "yes" ] ||[ $delete = "Y" ] ||[ $delete = "y" ] || [ $delete = "YES" ]
then

	rm -r $DBName
    echo "#####################################"
    echo "$DBName is Deleted"
    source Menu.sh
else
echo "#####################################"
    echo "try again invalid input"
    source Menu.sh

fi
else
	
	echo "try again invalid input"
    source DeleteDB.sh
	select option in "Re-enter name of Database" "Back to Main Menu" "Exit"
	do
		case $option in
             "Re-enter name of Database")
            clear ; . createDB.sh ; clear ; break
            ;;
			 "Back to Main Menu")
            clear ; . Menu.sh ; clear ; break
            ;;
             "Exit")
                  exit
            ;;
			* ) echo "Invalid Option"
		esac
	done
fi