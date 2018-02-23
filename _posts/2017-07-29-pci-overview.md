---
layout: post
title: PCI overview
excerpt_separator: <!--more-->
---

PCI is a widespread bus for peripheral interconnection usually found on x86 platforms
(although originally designed with cross-platformness in mind).
It is also used as a transport layer for VirtIO devices - paravirtualization standard used in modern hypervisors.

<!--more-->

It is quite outdated but I decided to go over it in detail in order to implement a driver for my x86_64 OS
and then possibly move to the PCIe which is a bit more complicated.

Below is a short summary of what I have learned so far:
 - PCI devices are organized into a tree: there are up to 256 buses with up to 32 devices on each bus.
 - The PCI device can be controlled via the /Configuration space/. On x86 platform it can be accessed through the two 32-bit I/O ports.
   The first one contains the offset within the Confiuration space and the second one contains the data to be read or written.
 - On the conventional PCI the size of Configuration space can be as large as 256 bytes, 16 of them (first 4 32-bit registers) are mandatory.
 - Each PCI device is uniquely identified by its DeviceID, VendorID, Class code, and Subclass code.
 - The rest of registers are device-dependent. Among them: Base Address Registers (BARs) contain memory spaces
   and/or I/O port spaces which serve as a comunication channels to the PCI device.
 - The Capabilities pointer is an 4-byte aligned 8-bit address of first entry in the linked list of device /capabilities/ located at the
   tail of Configuration space.
 - Each entry in capability list contains at least 2 bytes: capability id and /next/ pointer (offset in configuration space).
   The rest is device-specific data.
