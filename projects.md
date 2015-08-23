---
layout: page
title: Projects
---
Here is a list of my projects, which you can find on my [GitHub page](https:/github.com/RostakaGmfun).

##rpi-uart-boot
A simple bootloader over UART for Raspberry Pi 1 (tested on model B+)

* Languages: C, ARM assembler, Python
* [Source code](https://github.com/RostakaGmfun/rpi-uart-boot)
* [Article](http://rostakagmfun.github.io/uploading-rpi-kernels-over-uart.html)

##Kaa
On summer 2015 I've made a lot of contributions to open-source IoT platoform `Kaa`.
Particularly, I've ported C Endpoint SDK to `ESP8266` chip (with WiFi onboard).

* Language: C
* [Repository](https://github.com/kaaproject/kaa)
* [Project site](http://kaaproject.org/)

##ESP8266-AT-Kaa
This project is based on Kaa integration into `ESP8266` platform.
The original `AT` firmware for `ESP8266` provides user with ability to estabilish a connection via WiFi, 
and turn `ESP8266` into a TCP server (as a WiFi AP) using a set of commands send through a serial port. 
`ESP8266-AT-Kaa` is a clone of original firmware, but with support of Kaa transport channels.
This is currently work in progress and still does not support all the features that are planned.

* Language: C
* [Source code](https://github.com/kaaproject/ESP8266-AT-Kaa)

##modwm
`modwm` is a X11 window manager. The project is dead :(

* Language: C
* [Source code](https://github.com/RostakaGmfun/modwm)

##bfuck
`bfuck` is a Brainfuck language interpreter which I wrote just for learning purposes 
(actually, I write everything just for having fun and learning :D)

* Language: C
* [Source code](https://github.com/RostakaGmfun/bfuck)
* [Article about Brainfuck](http://rostakagmfun.github.io/brainfuck-programming.html)

##PixelGear Engine
I have been writing this game engine for a few months and then
just gave up because the source code was cluttered a lot.
It uses SDL2 for window management, OpenGL 3 for graphics drawing 
and [Bullet Physics Library](http://bulletphysics.org/) for rigid body dynamics

* Language: C++
* [Source code](https://github.com/RostakaGmfun/PixelGearEngine)
* [Article about my engine](http://rostakagmfun.github.io/pxg-engine-design.html)


