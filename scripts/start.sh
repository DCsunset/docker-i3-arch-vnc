#!/bin/bash

set -e

# Run init.sh if it exists
[[ -f /scripts/init.sh ]] && /scripts/init.sh && rm /scripts/init.sh

# current user
CUSER=${USERNAME:-root}
# add user if specified
if [ ! -z $USERNAME ]; then
	HOMEDIR="/home/$USERNAME"
	# Check if user exists
	if ! id "$USERNAME" &> /dev/null; then
		useradd -m -G wheel $USERNAME
		# delete password
		passwd -d $USERNAME
		echo "%wheel ALL=(ALL:ALL) ALL" >> /etc/sudoers
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

chown -R $CUSER:$CUSER "$HOMEDIR"
# Remove lock since stopping containers won't remove it
rm -f /tmp/.X0-lock

echo Starting vncsession...
vncsession $CUSER :0

# Start noVNC
if [ "$DISABLE_NOVNC" != "true" ]; then
	/noVNC/utils/launch.sh
else
	# prevent process from exiting
	tail -f /dev/null
fi
