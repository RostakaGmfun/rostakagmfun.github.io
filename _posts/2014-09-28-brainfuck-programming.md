---
layout: post
title: Brainfuck programming
permalink: brainfuck-programming.html
description: Brainfuck is esoteric programming language which was developed in 1993 by Urban Muller. It consists of only 8 operators and is not suited for writing practical applications - its purpose is to challenge programmers.
tags: [programming, tutorial, esolang, brainfuck]
categories: [tutorial, programming]
---

## Introduction

`Brainfuck` is esoteric programming language which was developed in 1993 by Urban Muller.
It consists of only 8 operators and is not suited for writing practical applications - its purpose is to challenge programmers.

## Interpreter

Writing `Brainfuck` interpreter is quite a trivial task, so I have written my own. However, there are a lot of others, so you can pick up any of them.

## Syntax

As it was noted above, the syntax of `Brainfuck` (`BF` for short) consists of 8 operators. Before naming them let’s look on how `BF` actually works.
Operators

The program consists of sequence of 8 possible operators and are executed one by one in the order they are fed to the interpreter.
The memory itself consists of (by official design) `30k` cells of one-byte size.
However, different variations exist (like word or double-word cell size and variable number of cells).
At the start all cells are initialized to `0` and the current cell pointer points to the first cell.
In `C` language this can be designated as:
{% highlight c linenos %}
    char *memory = (char*)malloc(NUM_CELLS);
    memset(memory,0,NUM_CELLS);
{% endhighlight %}
Two operators are used to increase and decrease cell pointer:
{% highlight bash %}
    > means memory++ and
< means memory--
{% endhighlight %}
Another two operators increment or decrement value at the current cell:
{% highlight bash %}
    +  means  *memory++  and
-  means  *memory--
{% endhighlight %}
Next pair of operators are used for I/O:
{% highlight bash %}
    . means printf("%c",memory); and
, means scanf("%c",memory);
{% endhighlight %}
The last pair of operators is the most interesting as they are used for branching:
{% highlight bash %}
    [ is used for opening loop block and
]  for closing it
{% endhighlight %}
The code inside square brackets will be executed until value of current cell won’t be zero:
{% highlight c linenos %}
    while(*memory)
        /* execute code */
{% endhighlight %}

## Comments

Any other characters are ignored by Brainfuck interpreter.
That means, that you can write any text in your Brainfuck program unless it does not contain 8 characters used to mark operators.

## Simple BF programs

When you are learning new programming language, you probably first write a classic “HelloWorld” program.
However, displaying string in Brainfuck is not that easy thing as you might think.
So we will start with such a code:
{% highlight bash %}
    +++++ [-]
{% endhighlight %}
In this program we first increment current (actually first) cell to `5` and then go in a loop which will decrement a value until it reaches `0`.
It isn’t hard to guess that the loop will iterate five times. Let’s look at more complex program which adds two numbers together:
{% highlight bash %}
    +++ > +++++ [-<+>]
{% endhighlight %}
First it sets first cell to `3`, than moves on to the next cell and sets it to `5`:
{% highlight bash %}
    [3][5]
{% endhighlight %}
Next, program enters a loop which iterates until the second cell (with value `5`) will be equal to `0`.
In each iteration the value of second cell is decremented and the value of first cell incremented.
As the program terminates, the value of first cell will be equal to `8` and the second cell will be equal to zero:
{% highlight bash %}
    [8][0]
{% endhighlight %}
Subtraction looks much like addition except one operator:
{% highlight bash %}
    ** +++++ > ++ [ -<-> ]
{% endhighlight %}
Since multiplication is addition repeated `n` times, multiplying two numbers in `Brainfuck` is not that hard:
{% highlight bash %}
    **+++++  [>++<-]**
{% endhighlight %}

## HelloWorld Program

At last, we get to the famous `HelloWorld` program.
Outputting some text in Brainfuck is a real challenge since you should designate each character with appropriate `ASCII` code:
{% highlight bash linenos %}
    Program to print string "Hello world!"
    ASCII codes
    H 72 7*10 plus 2
    e 101 10*10 plus 1
    l 108 101 plus 7
    o 111 108 plus 3
    _space_ 32 4*8
    W 87 8*10 plus 7
    o 111
    r 114 111 plus 3
    l 108
    d 100 10*10
    ! 33 32 plus 1
    newline 10

    +++++ ++ [> +++++ +++++ <-] >++. print H
    > +++++ +++++ [> +++++ +++++ <-] >+. print e
    +++++ ++ .. print ll
    +++ . print o
    > ++++ [> +++++ +++ <-] >. print space
    > +++++ +++ [> +++++ +++++ <-] > +++++ ++ . print W
    <<<< . print o
    +++ . print r
    ----- - . print l
    ----- --- . print d
    >>+. print !
{% endhighlight %}

## Conclusion

Brainfuck is really interesting programming language which makes you think out of the box,
especially while solving complex tasks and optimizing your programs.
