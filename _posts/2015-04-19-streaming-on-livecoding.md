---
layout: post
title: Streaming development at LCTV
permalink: streaming-on-livecoding.html
description: Recently I've set up a streaming channel on livecoding.tv and I'm going to share my impressions about streaming.
tags: [streaming game-engine]
keywords: streaming project
category: streaming
comments: true
---

# Introduction
Recently I've set up a streaming channel on [livecoding.tv](https://livecoding.tv/rostakagmfun/). After a few streaming sessions I came up to the idea that streaming your development
process is really fun and addictive. 

Particulary, you have a special feeling that folks are watching you and you don't have even a single chance to make wrong design choice,
write bad code or spend your coding time watching funny pics and reading you feed on social networks. Additionally, 
if you use the mic to answer viewers' questions and comment on what you are doing time at a time, you get an opportunity to practice your English speaking skills
(in case you are non-English and still want to stream in English as me).

# Setting up OBS on Debian
As a true Linux user, I got a bit of headache setting up [OpenBroadcastSoftware](https://obsproject.com/) on my system.
Except the fact that I had to compile OBS and it's dependencies from sources, the official srteaming guide, provided on livecoding.tv, didn't work for me
(there were problems with text readability).

Fortunately, LCTV support contacted me and we managed to get the sufficient quality perfectly fitted in 1.5 mbs rate.
The secret was to descrease FPS of video stream and (hell yeah!) increase font size in editor.

Here are some screenshots of OBS settings tabs which may be helpful for Deian users:

![Otput tab](/public/streaming-on-livecoding/output.png)

![Audio tab](/public/streaming-on-livecoding/video.png)

Also pay attention to your editor fonts. Mine choice is **Inconsolata Bold** 14pt and it is pretty visible when streaming with the settings shown above.

# General advices
I am still not very popular streamer on LCTV (but I hope the glory time will come!) but I've learned some things about streaming. My advice is to spend half an hour
designing nice channel page splash screen. For example, here is mine (I tried to make it funny and informative):

![Splash screen](/public/streaming-on-livecoding/splash.png)

And don't forget to add interesting stream description - write about you and your projects just a couple of sentences.

# Conclusion
LCTV is a great project to learn, communicate with developers and show off your skills. So I invite you, folks, to joing the community and start streaming.
Or, in case you have not enough confidence, watch other people's channels and acquire knowledge. But remember, that experience can be gained only while practicing a lot,
so get up your lazy ass (or put it in front of a PC/programming book) and start coding!
