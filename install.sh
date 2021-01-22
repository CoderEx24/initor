#!/bin/bash

echo "BlueArrow - Starting to prepare that bad boi"
echo "Checking..."

# checking for config
# exit if it doesn't exists
if [ ! -f './config' ]; then
    echo "config not found, exiting"
    exit 0
fi

# checking for program_list
# exit if it doesn't exists
if [ ! -f './program_list' ]; then
    echo "program_list not found, exiting"
    exit 0
fi

# include config
source ./config

# checking for install_cmd command
# exit if not set
if [ "$install_cmd" = "" ]; then
    echo '$install_cmd is not set, exiting'
    exit 0
fi

echo "Checks done, all good"

copy_dotfiles()
{
    echo "Copying dotfiles"
    cp -r -v ./dotfiles/* ~/
    echo "Done"
}

install_programs()
{
    if [ $# -eq 0 ]; then
        programs_array=($(cat ./program_list | sed "s/\n/ /g"))
    else
        programs_array=($@)
    fi
    failed_programs=

    for program in "${programs_array[@]}"
    do
        if ! $install_cmd $program >/dev/null 2>&1
        then
            choice='y'
            read -p "failed to install $program, retry [Y/n] " choice
            choice="$(echo $choice | tr '[:upper:]' '[:lower:]')"
            [ "$choice" = "y" ] && failed_programs="$program $failed_programs"
        fi
    done

    [ "$failed_programs" != "" ] && install_programs "$failed_programs"
}

run_scripts()
{
    if [ $# -eq 0 ]; then
        scripts_array=($(ls ./scripts | sort -n | sed "s/\n/ /g"))
    else
        scripts_array=($@)
    fi
    failed_scripts=

    for script in "${scripts_array[@]}"
    do
        echo "Running $script"
        chmod +x ./scripts/$script
        if ! ./scripts/$script >/dev/null 2>&1
        then
            choice='y'
            read -p "failed to execute $script, retry [Y/n] " choice
            choice="$(echo $choice | tr '[:upper:]' '[:lower:]')"
            [ "$choice" = "y" ] && failed_scripts="$script $failed_scripts"
        fi
    done

    [ "$failed_scripts" != "" ] && run_scripts "$failed_scripts"
}

copy_dotfiles
install_programs
run_scripts
