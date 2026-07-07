#! /bin/bash
version_app=0.0.1

function init(){
    clear
    echo
    sleep 1
    echo "Initializing program .."
    sleep 1
}

function create_file() {

    read -p "Enter file name: " file_name
    echo "Creating file $file_name"
    
    if [[ -f "$file_name" ]]
    then
       echo "$file_name already exist"
       sleep 1
       read -p "Do you want to overwrite $file_name? enter [y]: " choice
       if [[ $choice == "y" ]]
       then
          touch "$file_name"
          echo "name | user name | password | role" > "$file_name"
          sleep 1
          echo "$file_name has been overwritten"
       else
          read -p "Enter new file name : " new_file_name
          touch $new_file_name
          echo "name | user name | password | role" > "$new_file_name"
          sleep 1
          echo "$new_file_name has been created"
       fi
    else
       echo "Creating credential file $file_name"
       sleep 1
       touch "$file_name"
       echo "name | user name | password | role" > "$file_name"
       sleep 1
       echo "$file_name has been created"
    fi

    # echo "name | user name | password | role" > "$file_name"
    # sleep 1
    # echo "$file_name has been created"
}

menu(){
    echo "-----------------------------"
    echo "-    Credential Manager     -"
    echo "-    $version_app                  -"
    echo "-----------------------------"
    echo "- 1. Create file            -"
    echo "- 2. Update credential      -"
    echo "- 3. Delete credential      -"
    echo "- 4. Search credential      -"
    echo "- 5. List credential        -"
    echo "- 6. Exit                   -"
    echo "-----------------------------"
    read -p "Enter choice: " user_select
    echo "-----------------------------"
}

main() {
    init
    clear
    while true
    do
        menu
        case $user_select in
            "1" ) 
                echo "Creating credential file..."
                sleep 1
                create_file
                ;;
            "2" )
                echo "Testng updating file..."
                sleep 1
            ;;
            "3" )
                echo "Testng deleting file..."
                sleep 1
            ;;
            "4" ) 
                echo "Testng searching file..."
                sleep 1
            ;;
            "5" ) 
                echo "Testng display file..."
                sleep 1
            ;;
            "6" ) 
                echo "Exit app.."; exit 0
            ;;
            * ) 
                echo "Invalid input"
                sleep 1
            ;;
        esac
        
        echo ""
        read -p "Press enter to continue.."
        clear
    done
}

main