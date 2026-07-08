#!/bin/bash

validate_file() {

    local file_name=$1

    if [[ -z "$file_name" ]]; then
        echo "Error: filename required"
        return 1
    fi

    if [[ ! -f "$file_name" ]]; then
        echo "Error: $file_name does not exist"
        return 1
    fi

    return 0
}

create_file() {

    local file_name=$1


    if [[ -z "$file_name" ]]; then
        echo "Error: filename required"
        return 1
    fi


    if [[ -f "$file_name" ]]; then
        echo "$file_name already exists"
        return 1
    fi


    echo "name | user name | password | role" > "$file_name"

    echo "$file_name created successfully"
}


add_credential() {

    local file_name=$1
    local name=$2
    local username=$3
    local password=$4
    local role=$5


    validate_file "$file_name" || return 1


    if [[ -z "$name" || -z "$username" || -z "$password" || -z "$role" ]]; then
        echo "Error: missing credential information"
        return 1
    fi


    if grep -q "^$name |" "$file_name"; then
        echo "Credential '$name' already exists."
        return 1
    fi


    echo "$name | $username | $password | $role" >> "$file_name"

    echo "Credential '$name' added successfully."
}

update_credential() {

    local file_name=$1
    local credential_name=$2
    local username=$3
    local password=$4
    local role=$5


    validate_file "$file_name" || return 1


    if [[ -z "$credential_name" || -z "$username" || -z "$password" || -z "$role" ]]; then
        echo "Error: missing credential information"
        return 1
    fi


    if grep -q "^$credential_name |" "$file_name"; then

        sed -i.bak \
        "s/^$credential_name |.*/$credential_name | $username | $password | $role/" \
        "$file_name"

        rm "$file_name.bak"

        echo "$credential_name updated"

    else

        echo "$credential_name not found"
        return 1

    fi
}


delete_credential() {

    local file_name=$1
    local credential_name=$2


    validate_file "$file_name" || return 1


    if [[ -z "$credential_name" ]]; then
        echo "Error: credential name required"
        return 1
    fi


    if grep -q "^$credential_name |" "$file_name"; then

        sed -i.bak "/^$credential_name |/d" "$file_name"

        rm "$file_name.bak"

        echo "$credential_name deleted"

    else

        echo "$credential_name not found"
        return 1

    fi
}


search_credential() {

    local file_name=$1
    local credential_name=$2


    validate_file "$file_name" || return 1


    if [[ -z "$credential_name" ]]; then
        echo "Error: credential name required"
        return 1
    fi


    local result

    result=$(grep "^$credential_name |" "$file_name")


    if [[ -n "$result" ]]; then

        echo "$result"

    else

        echo "$credential_name not found"
        return 1

    fi
}


list_credential() {

    local file_name=$1


    validate_file "$file_name" || return 1


    echo "Credentials:"
    cat "$file_name"
}

show_help() {
    echo "Credential Manager v$version_app"
    echo
    echo "Usage:"
    echo "  $0 create <file>"
    echo "  $0 add <file> <name> <username> <password> <role>"
    echo "  $0 update <file> <name> <username> <password> <role>"
    echo "  $0 delete <file> <name>"
    echo "  $0 search <file> <name>"
    echo "  $0 list <file>"
}

main() {

    command=$1

    case "$command" in
        create)
            create_file "$2"
            ;;

        add)
            add_credential "$2" "$3" "$4" "$5" "$6"
            ;;

        update)
            update_credential "$2" "$3" "$4" "$5" "$6"
            ;;

        delete)
            delete_credential "$2" "$3"
            ;;

        search)
            search_credential "$2" "$3"
            ;;

        list)
            list_credential "$2"
            ;;

        *)
            show_help
            ;;
    esac
}

main "$@"