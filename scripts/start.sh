#!/bin/bash

set -e

# Run init.sh if it exists
[[ -f /scripts/init.sh ]] && /scripts/init.sh && rm /scripts/init.sh

# add user if specified
if [ ! -z $USERNAME ]; then
	pacman -S --noconfirm sudo
	useradd $USERNAME
	usermod -aG sudo $USERNAME
fi

umask 0077                # use safe default permissions
mkdir -p "$HOME/.vnc"
chmod go-rwx "$HOME/.vnc" # enforce safe permissions

# Start TigerVNC
if [ ! -z $VNC_PASSWD ]; then
	vncpasswd -f <<< "$VNC_PASSWD" > "$HOME/.vnc/passwd"
fi

vncsession ${USERNAME:-root} :0

# Start noVNC
/noVNC/utils/launch.sh
