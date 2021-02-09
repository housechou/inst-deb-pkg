#!/bin/bash
 
# install samba server
SAMBA_USERS="samba_test"
SAMBA_DIR=/srv/samba
SAMBA_PASS="lovingsamba"

sudo apt-get install -y samba
sudo mkdir -p $SAMBA_DIR
sudo chgrp sambashare $SAMBA_DIR
for u in $SAMBA_USERS;do
    sudo useradd -M -d $SAMBA_DIR/$u -s /usr/sbin/nologin -G sambashare $u
    sudo mkdir $SAMBA_DIR/$u
    sudo chgrp sambashare $SAMBA_DIR/$u
    sudo chmod 770 $SAMBA_DIR/$u
    echo -ne "$SAMBA_PASS\n$SAMBA_PASS\n" | sudo smbpasswd -a -s $u
    sudo smbpasswd -e $u
    echo "[$u]
      path = $SAMBA_DIR/$u
      browseable = yes
      read only = no
      force create mode = 0660
      force directory mode = 2770
      valid users = @sambashare" | sudo tee -a /etc/samba/smb.conf
done
sudo systemctl restart smbd
sudo systemctl restart nmbd
                                     
