#!/usr/bin/bash
# Justin's Auto-Configuration Script
# by Justin Saluja <salujajustin@gmail.com>

################################################################################
# Variables
################################################################################
osname=$(uname)
name=justin

source packages/apt
source packages/bspwm
source packages/cargo
source packages/npm

# test if STRING = 0. If true, set variable = git repo
[ -z "$bspwm_repo" ] && bspwm_repo="https://github.com/baskerville/bspwm.git"
[ -z "$sxhkd_repo" ] && sxhkd_repo="https://github.com/baskerville/sxhkd.git"
[ -z "$radare_repo" ] && radare_repo="https://github.com/baskerville/sxhkd.git"

################################################################################
# Functions
################################################################################

if type apt >/dev/null 2>&1; then
    # install() { apt install -y "$1" >/dev/null 2>&1 ; }
    install() { apt install -y "$1" ; }
fi

    
installgroup() { \
    pkgs=("$@")
    for i in "${pkgs[@]}";
        do
            install "$i" || error "Error installing packages."
        done
}

xinitrc() { \
    FILE=/home/justin/.xinitrc
    if [[ ! -f "$FILE" ]]; 
        then echo "exec bspwm" > $FILE;
    fi 
}

error() { clear; printf "ERROR:\\n%s\\n" "$1"; exit; }

checkroot() { \
    if [[ $(id -u) -ne 0 ]];
        then echo "To run Ubuntu bootstrapper, run script as root...";
        exit 1;
    fi
}

ask() { \
    pkgs=("$@")
    echo -n "Do you want to continue installation? (y/n)? "
    read answer
    if [ "$answer" != "${answer#[Yy]}" ] ;then
        installgroup "${pkgs[@]}" 
        echo
    fi
}

askinstall() { \
    pkgs=("$@")
    echo "The following packages will be installed:"
    echo "${pkgs[@]}" 
    ask "${pkgs[@]}"
}

welcomemsg() { \
    dialog --title "Welcome!" --msgbox "Welcome to Justin's Bootstrapping Script!\\n\\nThis script will automatically install a fully-featured Linux desktop, which I use as my main machine.\\n\\n" 10 60
}

putgitrepo() { # Downloads a gitrepo $1 and places the files in $2 only overwriting conflicts
	[ -z "$3" ] && branch="master" || branch="$repobranch"
	dir=$(mktemp -d)
	[ ! -d "$2" ] && mkdir -p "$2"
	chown -R "$name":wheel "$dir" "$2"
	sudo -u "$name" git clone --recursive -b "$branch" --depth 1 "$1" "$dir" >/dev/null 2>&1
	sudo -u "$name" cp -rfT "$dir" "$2"
} 

zshinit() { \
    # zshdir=$(mktemp -d)
    # echo "${zshdir}/install.sh"
    # wget --directory-prefix=$zshdir https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
    # chown -R "$name":wheel "$dir" "$2"

    # sudo -u $name sh "${zshdir}/install.sh" --unattended --keep-zshrc
    # wget -O /home/$name/.oh-my-zsh/custom/themes/common.zsh-theme https://raw.githubusercontent.com/jackharrisonsherlock/common/master/common.zsh-theme
    # sed -i "s/^$name:\(.*\):\/bin\/.*/$name:\1:\/bin\/zsh/" /etc/passwd

    zshinstalldir=/tmp/zsh/
    zshinstall=/tmp/zsh/install.sh
    wget --directory-prefix=$zshinstalldir https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
    sudo -u $name sh $zshinstall --unattended --keep-zshrc
    wget -O /home/$name/.oh-my-zsh/custom/themes/common.zsh-theme https://raw.githubusercontent.com/jackharrisonsherlock/common/master/common.zsh-theme
    sed -i "s/^$name:\(.*\):\/bin\/.*/$name:\1:\/bin\/zsh/" /etc/passwd
}



################################################################################
# Main
################################################################################

# Must run script as root
checkroot

# Packages install
# askinstall "${ADMIN[@]}"
# askinstall "${DEVEL[@]}"
# askinstall "${DOC[@]}"
# askinstall "${EDITORS[@]}"
# askinstall "${FONTS[@]}"
# askinstall "${GRAPHICS[@]}"
# askinstall "${MISC[@]}"
# askinstall "${NET[@]}"
# askinstall "${PYTHON[@]}"
# askinstall "${SHELLS[@]}"
# askinstall "${SOUND[@]}"
# askinstall "${TEX[@]}"
# askinstall "${TEXT[@]}"
# askinstall "${UTILS[@]}"
# askinstall "${VCS[@]}"
# askinstall "${VIDEO[@]}"
# askinstall "${WEB[@]}"
# askinstall "${X11[@]}"

# Bspwm dependencies install
# askinstall "${BSPWM[@]}"

# xinit file 
# xinitrc

# putgitrepo "$dotfilesrepo" "$HOME/code/clones/$name" "$repobranch" 
# repobranch=master
# putgitrepo "$bspwm_repo" "/home/$name" "$repobranch" 
# putgitrepo "$sxhkd_repo" "/home/$name" "$repobranch" 

# Install OhMyZsh as current user and make default shell
# zshinit
