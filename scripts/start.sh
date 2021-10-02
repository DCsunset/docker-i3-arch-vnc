#!/bin/bash

set -e

# Run init.sh if it exists
[[ -f /scripts/init.sh ]] && /scripts/init.sh && rm /scripts/init.sh

# current user
CUSER=${USERNAME:-root}
# add user if specified
if [ ! -z $USERNAME ] ; then
	HOMEDIR="/home/$USERNAME"
	if [ ! -d "$HOMEDIR" ]; then
		pacman -S --noconfirm sudo
		useradd -m -G wheel $USERNAME
		sed -i "s/^# %wheel ALL=(ALL) ALL$/%wheel ALL=(ALL) ALL/g" /etc/sudoers
	fi
else
	HOMEDIR="/root"
fi



umask 0077                # use safe default permissions
mkdir -p "$HOMEDIR/.vnc"
chmod go-rwx "$HOMEDIR/.vnc" # enforce safe permissions

# Start TigerVNC
if [ ! -z $VNC_PASSWD ]; then
	vncpasswd -f <<< "$VNC_PASSWD" > "$HOMEDIR/.vnc/passwd"
fi

chown -R $CUSER "$HOMEDIR/.vnc"

vncsession $CUSER :0

# Start noVNC
/noVNC/utils/launch.sh
