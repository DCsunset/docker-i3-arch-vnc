# docker-i3-arch-vnc

[![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/dcsunset/i3-arch-vnc)](https://hub.docker.com/r/dcsunset/i3-arch-vnc)
[![Docker Image Size](https://badgen.net/docker/size/dcsunset/i3-arch-vnc)](https://hub.docker.com/r/dcsunset/i3-arch-vnc)

A docker image of Arch Linux with i3wm and VNC support.


## Pull image

```
docker pull dcsunset/i3-arch-vnc
```

## Usage

Simple usage:

```
docker run -d --name i3-arch-vnc -p 5900:5900 -p 6080:6080 -e VNC_PASSWD=password dcsunset/i3-arch-vnc
```

Then visit <http://localhost:6080> to visit noVNC UI.
Or you can use a different VNC client (like TigerVNC client)
and connect to localhost:5900.

If `VNC_PASSWD` is not set,
then the security type of tigervnc is set to None,
it is **insecure** when exposing the container on the Internet.

## Exposed ports

* 5900: Used for VNC interface
* 6080: Used for noVNC Web UI

## Installed applications

* tigervnc
* noVNC
* wget
* alacritty (a terminal emulator)

## Build

```
docker build -t i3-arch-vnc .
```


## FAQ

### Scaling

By default, noVNC's scaling mode is set to None.
It can be changed in the noVNC panel easily.


## License

MIT License
