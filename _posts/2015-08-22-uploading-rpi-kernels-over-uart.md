---
layout: post
title: Uploading Raspberry Pi kernels over UART
permalink: uploading-rpi-kernels-over-uart.html
description: Recently I've bought Raspberry Pi Model B+ in order to practice low-level system and kernel programming. To make my life easier I've written simple bootloader
tags: [kernel-develoment arm rapsberrypi]
keywords: kernel-development RaspberryPi bootloader programming C assembler UART
category: raspberrypi
comments: true
---
Recently I've bought Raspberry Pi Model B+ in order to practice low-level system and kernel programming. But before diving immediately into kernel development,
I wrote a helpful tool to make my development easier and more pleasant.

A typical kernel developemnt cycle for Raspberry Pi may consits of copying kernel image into `boot` partition of MicroSD Card and inserting it into device.
However, this appears to be rather cumbersome, so I've came up with an idea of writing tiny bootloader over UART (Universal Asynchronous Raceiver/Transmitter) 
for personal purposes. The source code is, as usual, on [github](https://github.com/RostakaGmfun/rpi-uart-boot).

Using the bootloaer is pretty simple: just copy the `kernel.img` to MicroSD and upload your own kernels using `rpi-uart-boot.py` tool.
The image will be loaded into `0x8000` address, just like the GPU bootloader does.
For more detailed instruction you can refer to `README.md` file in the root of source code repository.
