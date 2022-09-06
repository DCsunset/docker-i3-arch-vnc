#!/bin/bash

set -e

# Run init.sh if it exists
[[ -f /scripts/init.sh ]] && /scripts/init.sh && rm /scripts/init.sh
HOMEDIR="/home/docker_user"

umask 0077                # use safe default permissions
mkdir -p "$HOMEDIR/.vnc"
chmod go-rwx "$HOMEDIR/.vnc" # enforce safe permissions

# Start TigerVNC
if [ ! -z $VNC_PASSWD ]; then
	vncpasswd -f <<< "$VNC_PASSWD" > "$HOMEDIR/.vnc/passwd"
fi

chown -R docker_user:users "$HOMEDIR"
# Remove lock since stopping containers won't remove it
rm -f /tmp/.X0-lock

echo Starting vncsession...
vncsession docker_user :0

# Start noVNC
if [ "$DISABLE_NOVNC" != "true" ]; then
	/noVNC/utils/launch.sh
else
	# prevent process from exiting
	tail -f /dev/null
fi
