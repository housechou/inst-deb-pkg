#!/bin/bash

username=$(whoami)

sudo apt-get update
sudo apt-get install -y git
sudo apt-get install -y dialog

function install_vim () {
    sudo apt-get install -y vim-gtk3
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    if [ ! -f ~/.vimrc ];then
        cp ./.vimrc ~
        if [ "$username" = "root" ];then
            sed -i 's/\/home\/house/\/root/' ~/.vimrc
        else
            sed -i 's/\/home\/house/\/home\/$username/' ~/.vimrc
        fi
    fi
}

function install_docker () {
    sudo apt-get install -y \
            apt-transport-https \
            ca-certificates \
            curl \
            gnupg \
            gnupg-agent \
            software-properties-common
    sudo install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    sudo chmod a+r /etc/apt/keyrings/docker.gpg
    # Add the repository to Apt sources:
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
      $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
      sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
}

function install_tftp_server () {
    sudo apt install -y tftpd-hpa
    sudo cp ./tftpd-hpa /etc/default/
    sudo mkdir /tftpboot
    sudo chmod 777 /tftpboot
}

function install_ssh_server () {
    sudo apt-get install -y openssh-server
}

function install_fcitx () {
    sudo apt-get install -y \
		fcitx \
		fcitx-table-boshiamy \
		fcitx-frontend-gtk2 \
		fcitx-frontend-gtk3 \
		fcitx-ui-classic \
		kde-config-fcitx
    # install input method config tool
    sudo apt-get install -y im-config
}

function install_oh-my-zsh () {
    sudo apt-get install -y zsh
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    if [ -f ~/.zshrc ];then
        echo "Warning: backup ~/.zshrc to ~/.zshrc.bak "
        cp ~/.zshrc ~/.zshrc.bak
    fi
    cp ./.zshrc ~/
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    echo "source ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc
}

function install_build_essential () {
    sudo apt-get install -y \
        autoconf \
        automake \
        bc \
        bison \
        build-essential \
        bzip2 \
        cmake \
        coreutils \
        cpio \
        curl \
        default-jre-headless \
        dwarves \
        findutils \
        flex \
        gawk \
        grep \
        gzip \
        hardlink \
        help2man \
        lib32z1-dev \
        libc6-dev-i386 \
        libc6-i386 \
        libcgi-fast-perl \
        libcrypt-openssl-rsa-perl \
        libcurl4-gnutls-dev \
        libexpat1-dev \
        libgmp-dev \
        libmpc-dev \
        libmpfr-dev \
        libncurses5-dev \
        libssl-dev \
        libyaml-tiny-perl \
        libjansson-dev \
        ocaml \
        p7zip-full \
        patch \
        perl \
        procps \
        python \
        python3 \
        quilt \
        ruby \
        sed \
        sharutils \
        squashfs-tools \
        subversion \
        tar \
        tcl \
        texinfo \
        tree \
        unzip \
        wget \
        rsync \
        colormake \
        zlib1g-dev
}

# install ripgrep
function install_rg () {
    sudo apt-get install -y ripgrep
}

# install fd
function install_fd () {
    sudo apt-get install -y fd-find
    ln -s $(which fdfind) ~/.local/bin/fd
}

# install okular
function install_okular () {
    sudo apt-get install -y okular
}

function install_tmux_powerline () {
    sudo apt-get install -y fonts-powerline
    git clone https://github.com/housechou/tmux-powerline.git ~/.tmux/plugins/tmux-powerline
    cp .tmux-powerlinerc ~/
}
# install tmux
function install_tmux () {
    sudo apt-get install -y tmux
    sudo apt-get install -y cmake #for building tmux-mem-cpu-load
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    cp .tmux.conf ~/
    tmux start-server
    tmux new-session -d
    ~/.tmux/plugins/tpm/bin/install_plugins
    tmux kill-server
    install_tmux_powerline
    systemctl --user status tmux.service
}

cmd=(dialog --separate-output --checklist "Select packages you want to install:" 22 76 16)
# any option can be set to default to "on"
options=(1 "vim" off
         2 "tftp server" off
         3 "ssh server" off
         4 "build essential" off
         5 "docker" off
         6 "oh-my-zsh" off
         7 "rg" off
         8 "fd" off
         9 "okular" off
         10 "tmux" off
         11 "samba" off)
choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
clear
for choice in $choices
do
    case $choice in
        1)
            echo -e "\e[1mInstalling Vim"
            install_vim
            ;;
        2)
            echo -e "\e[1mInstalling TFTP Server"
            install_tftp_server
            ;;
        3)
            echo -e "\e[1mInstalling SSH Server"
            install_ssh_server
            ;;
        4)
            echo -e "\e[1mInstalling Build Essential"
            install_build_essential
            ;;
        5)
            echo -e "\e[1mInstalling Docker"
            install_docker
            ;;
        6)
            echo -e "\e[1mInstalling oh-my-zsh"
            install_oh-my-zsh
            ;;
        7)
            echo -e "\e[1mInstalling rg (line search tool instead of grep) "
            install_rg
            ;;
        8)
            echo -e "\e[1mInstalling fd (alternative find cmd)"
            install_fd
            ;;
        9)
            echo -e "\e[1mInstalling okular (pdf viewer)"
            install_okular
            ;;
        10)
            echo -e "\e[1mInstalling tmux"
            install_tmux
            ;;
        11)
            echo -e "\e[1mInstalling samba"
            ./install_samba.sh
            ;;
    esac
done
