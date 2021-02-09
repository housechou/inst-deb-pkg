#!/bin/sh

username=$(whoami)

cd ~
sudo apt-get update

# install git
sudo apt-get install -y git

# install vim
sudo apt-get install -y vim-gtk3
cp ./.vimrc ~
if [ "$username" = "root" ];then
    sed -i 's/\/home\/house/\/root/' ~/.vimrc
else
    sed -i 's/\/home\/house/\/home\/$username/' ~/.vimrc
fi

# install docker
sudo apt-get install -y \
	    apt-transport-https \
		ca-certificates \
		curl \
		gnupg-agent \
		software-properties-common

curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
sudo add-apt-repository --yes \
	"deb [arch=amd64] https://download.docker.com/linux/debian \
	$(lsb_release -cs) \
	stable"

sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io


# install tftp server
sudo apt install -y tftpd-hpa
sudo cp ./tftpd-hpa /etc/default/
sudo mkdir /tftpboot
sudo chmod 777 /tftpboot


# install ssh server
sudo apt-get install -y openssh-server

# install fcitx

sudo apt-get install -y \
		fcitx \
		fcitx-table-boshiamy \
		fcitx-frontend-gtk2 \
		fcitx-frontend-gtk3 \
		fcitx-ui-classic \
		kde-config-fcitx

# install input method config tool
sudo apt-get install -y im-config

# install oh-my-zsh
sudo apt-get install -y zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
cp ./.zshrc ~/
if [ "$username" = "root" ];then
    sed -i 's/\/home\/house/\/root/' ~/.zshrc
else
    sed -i 's/\/home\/house/\/home\/$username/' ~/.zshrc
fi
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
echo "source ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc



# install build essential
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
    git \
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


# install ripgrep
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/11.0.2/ripgrep_11.0.2_amd64.deb
sudo dpkg -i ripgrep_11.0.2_amd64.deb

# install fd
sudo apt-get install -y fd-find

# install shutter
sudo add-apt-repository --yes ppa:shutter/ppa
sudo apt-get update && sudo apt-get install -y shutter

