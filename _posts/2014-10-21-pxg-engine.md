---
layout: post
title: My own game engine or why I have given up writing it
permalink: pxg-engine-design.html
description: In this article I will highlight main problems of my own game engine and explain why good software design is so important.
tags: [c++, code design, game engine]
categories: [c++, code design, game engine]
---

## Introduction

I have been writing my own game engine since February till August this year.
The reason why I have given up writing it is self-evident if you look at it's code.
Most of all, the engine suffers from bad OO design. As the size of code has grown, it became really painful to add new features and fix bugs.
The main reasons for why this hell happened are:

* I haven't known much about OO patterns
* I was writing 3D engine for the first time, that is why I have concentrated on features rather than on clear code design

Things changed rapidly when I have started reading [Head First: Design Patterns](http://www.headfirstlabs.com/books/hfdp/).
I understood the mistakes I have made while writing my engine and in this article
I'm going to highlight some of the biggest mistakes in PixelGear Engine.

## The main class
Though I was targeting to eventually develop cross platform engine, it's code design really wasn't ready for this.
First of all, the whole window and context management boilerplate were encapsulated in single `pxgEngine` class.
Getting user input, creating window and context, counting frames per second made the `pxgEngine` class a real mess.
Furthermore, the HUD system was also somewhat dependent on `pxgEngine` class, since you should call `pxgEngine::setHUDManager()` to enable HUD rendering.

<script src="http://gist-it.appspot.com/https://github.com/RostakaGmfun/PixelGearEngine/blob/master/include/PXG.h?slice=30:74"></script>

## Node system
By initial concept both 3D objects and scenes in my engine should inherit an abstract `pxgNode` class.
This class should provide parent-child relations management, spatial transformations and object name handling.
In addition, `pxgNode` class included pure virtual functions for updating, rendering, and destroying nodes.
However, this system was implemented badly at the beginning and was totally broken as the number of objects has grown.
One of the numerous problems of `pxgNode` was `UpdateTransformation()` function.
It updates the world matrix from scale, translation and rotation vectors and is meant to be called in `Update()` pure virtual function.
Now I can say, that such system should have been implemented with [Template Method Pattern](http://en.wikipedia.org/wiki/Template_method_pattern).

<script src="http://gist-it.appspot.com/https://github.com/RostakaGmfun/PixelGearEngine/blob/master/include/pxgNode.h?slice=14:44"></script>

## World
At the beginning the world system was meant to be a special scene, but later it turned into rather
big class with many methods and HAS-A relationships with other engine classes.
The inheritance of `pxgWorld` from `pxgNode` was not required at all. `pxgWorld` managed physics,
background, post-processing and object picking systems completely or partially on its own.
In fact, this class needed complete redesign most of all among other engine classes.

<script src="http://gist-it.appspot.com/https://github.com/RostakaGmfun/PixelGearEngine/blob/master/include/pxgWorld.h?slice=26:62"></script>

## pxgObject and friends
This class was used to render both 3D models an 3D sprites;
it also used its own system for child mesh management (despite inheriting from `pxgNode`.
In fact, `pxgNode`s parent-child system was not used by any class in the engine).
Although `pxgObject` used high-level engine classes for shader, buffer and texture management,
the `pxgObject.cpp` contains direct OpenGL calls (to manage vertex array and actually render the object).
You should not be a professional programmer to note that `pxgObject` system was completely wrong.
<script style="overflow:auto" src="http://gist-it.appspot.com/https://github.com/RostakaGmfun/PixelGearEngine/blob/master/src/pxgObject.cpp?slice=254:344"></script>
As there were no higher-level abstractions for vertex arrays and draw calls,
the same code should be written again and again every time you implement new renderable object (e.g. terrain, HUD object, particle system and so on).

## OS abstractions and math library
In short, there are no OS abstractions in PixelGear. I thought i don't need them.
In fact, I didn't need them while deploying the engine only on my development system (Linux).
As for the math library, which is really important part of 3D rendering system,
I have used really robust [GLM](http://glm.g-truc.net/) - OpenGL Mat Library, which mimics GLSL syntax and is really fast.
However, in my engine only the small part of this great library was used. As `GLM` used C++ templates intensively, it slowed down compilation of the engine.
That is why it is good idea to write your own math library to fit particular purposes.
The same with standard C++ library - it slows things down both at compile time and runtime - that is why it is good to write your own containers and string classes.

## Engine Features
Event though PixelGear engine suffered from bad OO design, it has some features. Here is full feature list of my engine

> * Loading meshes with materials from Wavefront OBJ format ( tested with Blender exporter )
* Loading textures from various image formats ( powered by SOIL )
* Compiling vertex, geometry and fragment shaders
* Shader system, which supports basic stuff for developing your own shaders ( uniforms, attributes and textures )
* Shader library which provides basic shaders
* Simple lighting system
* Cube and plane meshes
* Skyboxes
* Keyboard and mouse input
* Simple ( yet buggy ) terrain system
* Post processing ( WIP )
* Object picking
* Blender exporter plugin in custom format ( WIP )
* 2D textures and text rendering
* Rigid body dynamics ( powered by Bullet )

At last, here are some screenshots and videos:

### Terrain demo
<iframe width="570" height="340" src="//www.youtube.com/embed/FogCR0x93Zg?list=UU1VEk32Dv8l49nlaIclDyAw" frameborder="0" allowfullscreen></iframe>

### Physics demo
<iframe width="570" height="340" src="//www.youtube.com/embed/xiy6hlL0nYE?list=UU1VEk32Dv8l49nlaIclDyAw" frameborder="0" allowfullscreen></iframe>

### Screenshots
An effort to write a game

![An effort to write a game](/public/pxg-engine-design/gamedev-effort.png "An effort to write a game")

Scene loaded from OBJ and skybox

![Scene loaded from OBJ and skybox](/public/pxg-engine-design/scene.png "Scene loaded from OBJ and skybox")
