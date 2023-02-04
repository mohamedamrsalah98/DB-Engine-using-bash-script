#!/bin/bash 

 cd $DBName

function updateHeader(){
#     echo " enter the name of the table you want to update in it"
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
}
# cat $table
# read -p "enter record you would to update" reco

# awk -F : '{print $0}' $table sed -n '3,$p' | grep $reco 
# //////////////////////////////////////////////////////////////////////////////////////////

function updateColumn(){

cat $table
 
	read -p "Row number: " rowNum
    while ! [[ "$rowNum" =~ ^[0-9]+$ ]] || [[  $rowNum -gt ` awk -F : 'END{print NR}' $table `   ]]
    do  
        read -p "invalid value for Row Number & Enter an int value please" rowNum
    done
   
	read -p "Column name: " colName
    while [ -z $colName ] || [ "${colName//[!0-9]}" != "" ] || [[ $colName =~ ['!@#$%^&*()_+'] ]] || ! [[ `awk -F : 'NR==1{print $0}' $table | grep $colName` ]]
    do
        read -p "Invalid Column Name & enter a valid value" colName
    done

    ColNum=`awk -F":" '{for(i=1;i<=NF;i++){if( $i == "'$colName'" )print i}}' $table`
	val=`awk -F":" 'NR=='$rowNum' {print $'$ColNum'}' $table`
    read -p "Enter New Value You want to update " newVal
    sed -i "s/$val/$newVal/" $table
    cat $table


}

 select option in "Update Header" "Update Column" "Back To Menu"
do
    case $option in 
        "Update Header")

           updateHeader
            ;;
        "Update Column")

           updateColumn
            ;;
              "Back To Menu")
              clear;
              echo "######################### Welcome $table ################################";
            cd ..;
            source select.sh
            ;;
        *)  clear ; echo "Incorrect Choice try again" ;
         cd ..; source updateTable.sh  ;;
    esac
done
