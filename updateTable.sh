#!/bin/bash 
cd $DBName
# echo " enter the name of the table you want to update in it"
# read tableUpdate
while [ -z $table ] || [ "${table//[!0-9]}" != "" ] || [[ $table =~ ['!@#$%^&*()_+'] ]] || ! [ -f $table ]
do    
    echo "Invalid Input & Please enter a valid value"
    read table
done

    echo "enter the name of the column you want to update"
    read colname 

    while [  -z $colname ] || [ $colname == "ID"  ]
    do
        echo "invalid value(can't be empty or PK column)"
        echo "enter a valid value "
        read colname
    done
    if [  `sed -n 1p $table  | grep $colname`  ]
    then

        echo "enter the new value of the column $colname"
        read val
        while [ -z $val ] || [ "${val//[!0-9]}" != "" ] || [[ $val =~ ['!@#$%^&*()_+'] ]] || [ `sed -n 1p $table | grep $val ` ]
        do    
            echo "Invalid Input &Please enter a valid value"
            read val
        done
        `sed -i "s/$colname/$val/" $table`
        echo "do you want to change another column name ?"
        select reply in "Yes" "No" 
        do  
            case $reply in
            "Yes")
                clear;
                cd ..;
                source updateTable.sh
            ;;
            "No") 
            clear ;
            cd .. ;
            echo "########### Table Option ###########";
            source select.sh
            ;;
            *)
            echo "please enter a valid input"
            ;;
            esac
        done
    else
        echo "no column named $colname in $table table"
        echo " enter a valid value"
        cd .. 
        source updateTable.sh
    fi
    