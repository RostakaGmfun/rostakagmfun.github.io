---
layout: post
title: Utilizing I<sup>2</sup>C multibyte transfers
excerpt_separator: <!--more-->
---

I<sup>2</sup>C is a common hardware protocol to communicate with multiple low-speed peripherals located tightly on the board.
I<sup>2</sup>C is used mostly in the embedded devices.
That is why performance considerations are common when talking about I<sup>2</sup>C-enabled peripherals,
especially about those that consume or produce lots of data (like different kinds of sensors).

<!--more-->

A minimal unidirectional one-byte transfer of I<sup>2</sup>C communication looks like this:

1. Master sends a `START` condition bit.
2. Master sends a 7-bit (or 10-bit) slave address.
3. Master sends a `R/W` bit.
4. Slave sends `ACK`.
5. Master transfers or accepts an 8-bit packet of data to or form the requested slave.
6. If the transfer was master-to-slave, the slave sends `ACK` bit, otherwise the master sends `NACK` bit.
7. Master sends a `STOP` condition bit.

The number of bits sent is 20 (for 7-bit salve address), so the total overhead to send one byte is 12 bits.

It is a common case for the master to first write a request (e.g register address) and then accept the reply from the slave.
This is possible by sending the /repeated `START` condition/ just after the step 4.
The repeated `START` condition is then followed by steps 2-6 resulting in 11 bits overhead per data byte.
This way, the total overhead to transfer `N` bytes this way is `(1+7+1+1)*N+1` bits or `11*N+1` (for 7-bit slave address).

A good feature of I<sup>2</sup>C is to transfer multiple (unlimited!) number of bytes without going through the sequence of steps 2-6
to transfer every byte. This requires some support from the slave, though. The communication will look like this:

1. Master sends a `START` condition bit.
2. Master sends a 7-bit (or 10-bit) slave address.
3. Master sends a `R/W` bit.
4. Slave sends `ACK`.
5. Master sends repeated `START` condition bit.
5. Master transfers or accepts a variable number of 8-bit packets of data to or from the requested slave.
   The number of packets is specified by slave depending on its state.
   For each transferred byte, a single ACK bit is required from master or slave depending on the transfer direction.
7. Master sends a `STOP` condition bit.

In this case, the overhead is only `1+7+1+1+N+1` bits or `11+N` bits per byte (for 7-bit slave address).

As a consequence, to transfer e.g. 32 bytes from the sensor, you will save `(11*32+1)-(11+32) = 310` bits, which is about 38 bytes
(even more than you actually intended to transfer!).

Another great advantage of multi-byte transfer is that it can be issued with the single DMA transaction, which causes more
efficient utilization of the DMA and gives the CPU more time either do more work or to save more power.
