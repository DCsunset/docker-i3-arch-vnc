#!/bin/bash

umask 0077                # use safe default permissions
chmod go-rwx "$HOME/.vnc" # enforce safe permissions

# Start TigerVNC
if [ ! -z $VNC_PASSWD ]; then
	vncpasswd -f <<< "$VNC_PASSWD" > "$HOME/.vnc/passwd"
fi

vncsession root :0

# Start noVNC
/noVNC-${noVNC_version}/utils/launch.sh
