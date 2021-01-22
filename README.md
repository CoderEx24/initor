# Initor

this is a template repository in order to create shell scripts that prepares minimum linux distrobutions (like [Arch Linux](https://archlinux.org) or [Gentoo](https://gentoo.org))

### How to works?

This repository consists of the following:-

1. `install.sh`
    This is the main deal.
    This script does it all. It install the programs and run the scripts. You shouldn't need to change it. If needs a change, make a PR then

2. `config`
    This contains the configuration used by `install.sh`
    Currently, it only has one option, `install_cmd`, you should put the command
    which you will use to install software (for exmaple, `sudo pacman -S`, for Arch Linux)

3. `program_list`
    This contains a list of programs to install. It should contain the names of the packages
    you want to install. Each line should contain **ONE** package

4. `dotfiles/`
    This directory should contain your awesome dotfiles. `install.sh` will copy all of them
    to your home directory

5. `scripts/`
    This is where you would put other scripts that does other stuff. For example, maybe
    you want to clone all your amazing repos. You should make a script and put it there

### How to use it?
eazy
1. Click the `Use this template` to create another repo using this one as a starting point (note that you are not cloning the repo, for more details [click here](https://docs.github.com/en/github/creating-cloning-and-archiving-repositories/creating-a-repository-from-a-template))
2. set the `install_cmd` variable to the command used to install software in your choice distro (`sudo pacman -S` for Arch Linux for example)
3. put a list of the programs you want in `program_list`
4. put your dotfiles in `dotfiles`
5. put other stuff in `scripts`
6. push the changes to your repo

and that it. Now, you should have a way to make your linu distro the way you want

