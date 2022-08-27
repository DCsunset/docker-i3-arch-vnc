#!/bin/bash

set -e

# Install apps
pacman -Sy --noconfirm --needed xorg-server \
	wget tigervnc which \
	python-setuptools ttf-dejavu

# Install Terminal
pacman -S --noconfirm --needed terminator alacritty

# Install DE
#LXQT
#pacman -S --noconfirm --needed lxqt breeze-icons oxygen-icons
#LXDE
pacman -S --noconfirm --needed lxde

# Install noVNC
if [ "$DISABLE_NOVNC" != "true" ]; then
	export noVNC_version=1.2.0
	export websockify_version=0.10.0

	wget https://github.com/novnc/websockify/archive/v${websockify_version}.tar.gz -O /websockify.tar.gz \
		&& tar -xvf /websockify.tar.gz -C / \
		&& cd /websockify-${websockify_version} \
		&& python setup.py install \
		&& cd / && rm -r /websockify.tar.gz /websockify-${websockify_version} \
		&& wget https://github.com/novnc/noVNC/archive/v${noVNC_version}.tar.gz -O /noVNC.tar.gz \
		&& tar -xvf /noVNC.tar.gz -C / \
		&& mv /noVNC-${noVNC_version} /noVNC \
		&& cd /noVNC \
		&& ln -s vnc.html index.html \
		&& rm /noVNC.tar.gz
fi
