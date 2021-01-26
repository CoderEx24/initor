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

in `config`, there are a number of options you can set. These are

1. `install_cmd`
    This contains the command that you use to install software. it should include `sudo`, for example, for Arch Linux. `install_cmd` should be
    set to `sudo pacman -S`

2. `m_copy_dotfiles`
    Whether to copy dotfiles or not, 1 for true, 0 for false

3. `m_istall_sprograms`
    Whether to install te programs listed inn `program_list` or not, 1 for true, 0 for false

4. `m_run_scripts`
    Whether to run the scripts inside `scripts/` or not, 1 for true, 0 for false

5. `m_remove_after_finish`
    Whether to remove the directory containing initor or not, 1 for true, 0 for false

6. `m_reboot`
    Whether to reboot after `install.sh` finishes or not, 1 for true, 0 for false

`install_cmd` is mandentory. if it is blanck, the script exits
the rest are optional. And the script will get a default value to an unconfigured option

### How to use it?
eazy
1. Click the `Use this template` to create another repo using this one as a starting point (note that you are not cloning the repo, for more details [click here](https://docs.github.com/en/github/creating-cloning-and-archiving-repositories/creating-a-repository-from-a-template))
2. set the `install_cmd` variable to the command used to install software in your choice distro (`sudo pacman -S` for Arch Linux for example)
3. put a list of the programs you want in `program_list`
4. put your dotfiles in `dotfiles`
5. put other stuff in `scripts`
6. push the changes to your repo

(remember to remove the `.gitkeep` files from `dotfiles` and `scripts`)
and that it. Now, you should have a way to make your linu distro the way you want

if you want an example of how it works, see [my other repo](https://github.com/CoderEx24/blue-arrow)
