#!/bin/bash

echo "Initor - Starting to prepare that bad boi"
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
if [ -z "$install_cmd" ]; then
    echo '$install_cmd is not set, exiting'
    exit 0
fi

# checking for the other options
# if there is an option is not set, provide a default value
if [ -z "$m_copy_dotfiles" ]; then
    echo "m_copy_dotfiles is not set, setting to default (m_copy_dotfiles=1)"
    m_copy_dotfiles=1
fi

if [ -z "$m_install_programs" ]; then
    echo "m_install_programs is not set, setting to default (m_install_programs=1)"
    m_install_programs=1
fi

if [ -z "$m_run_scripts" ]; then
    echo "m_run_scripts is not set, setting to default (m_run_scripts=1)"
    m_run_scripts=1
fi

if [ -z "$m_remove_after_finish" ]; then
    echo "m_remove_after_finish is not set, setting to default (m_remove_after_finish=0)"
    m_remove_after_finish=0
fi

if [ -z "$m_reboot" ]; then
    echo "m_reboot is not set, setting to default (m_reboot=0)"
    m_reboot=0
fi

dotfiles_list_str=($(ls -A ./dotfiles/))
programs_list_str=($(cat ./program_list))
scripts_list_str=($(ls ./scripts/))

echo "Checks done, all good"
echo -e "install command is \"$install_cmd\""
[ $m_copy_dotfiles -eq 1 ] && \
    echo -e "Will copy the following files to HOME\n${dotfiles_list_str[@]}\n"
[ $m_install_programs -eq 1 ] && \
    echo -e "Will install the following programs\n${programs_list_str[@]}\n"
[ $m_run_scripts -eq 1 ] && \
    echo -e "Will run the following scripts\n${scripts_list_str[@]}\n"
[ $m_reboot -eq 1 ] && echo "Will reboot after it is done"

choice='y'
read -p "Proceed? [Y/n] " choice
if [ "$choice" = "n" ]; then
    echo -e "exiting, sad :'("
    exit 0
fi

copy_dotfiles()
{
    echo "Copying dotfiles"
    dotfiles=($(ls -A ./dotfiles))
    for dotfile in "${dotfiles[@]}"
    do
        echo "Copying $dotfile"
        cp ./dotfiles/$dotfile ~/
    done
    echo "Done"
}

install_programs()
{
    if [ $# -eq 0 ]; then
        programs_array=($(cat ./program_list))
    else
        programs_array=($@)
    fi
    failed_programs=

    for program in "${programs_array[@]}"
    do
        echo "Installing $program"
        echo "---------------------------------------------------------------"
        if ! $install_cmd $program
        then
            echo "---------------------------------------------------------------"
            choice='y'
            read -p "failed to install $program, retry [Y/n] " choice
            choice="$(echo $choice | tr '[:upper:]' '[:lower:]')"
            [ "$choice" = "y" ] && failed_programs="$program $failed_programs"
        fi
        echo "---------------------------------------------------------------"
    done

    [ "$failed_programs" != "" ] && install_programs "$failed_programs"
}

run_scripts()
{
    if [ $# -eq 0 ]; then
        scripts_array=($(ls ./scripts | sort -n))
    else
        scripts_array=($@)
    fi
    failed_scripts=

    for script in "${scripts_array[@]}"
    do
        echo "Running $script"
        chmod +x ./scripts/$script
        echo "---------------------------------------------------------------"
        if ! ./scripts/$script
        then
            echo "---------------------------------------------------------------"
            choice='y'
            read -p "failed to execute $script, retry [Y/n] " choice
            choice="$(echo $choice | tr '[:upper:]' '[:lower:]')"
            [ "$choice" = "y" ] && failed_scripts="$script $failed_scripts"
        fi
        echo "---------------------------------------------------------------"
    done

    [ "$failed_scripts" != "" ] && run_scripts "$failed_scripts"
}

[ $m_copy_dotfiles -eq 1 ] && copy_dotfiles
[ $m_install_programs -eq 1 ] && install_programs
[ $m_run_scripts -eq 1 ] && run_scripts

if [ $m_remove_after_finish -eq 1 ]; then
    dirname=`pwd`
    cd ..
    rm -rvf $dirname
fi

[ $m_reboot -eq 1 ] && sudo reboot
