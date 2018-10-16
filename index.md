---
layout: default
title: Welcome
---

# About

Hi!

My name is Rostyslav Kurylo and I am passionate about software, and technology behind it.
During my work days I am mostly busy with system programming for Linux and embedded platforms,
and that is also what I like to do in my spare time, though with more experiment and joy :)

I do not pretend to be a generalist, but I like to consider the whole hardware and software stack
when working on a project and make interesting obsevations about it.

This blog was initially meant to be a summary of what I've learned so far in the world of software engineering,
but tends to be updated with new contant very rarely, so don't judge it too strictly.

This blog uses slightly modified [jekyll-minimal-theme](https://github.com/henrythemes/jekyll-minimal-theme).

# Articles

{% for post in site.posts %}
  <h2 class='post-title'>
    <a href="{{ site.path }}{{ post.url }}">
      {{ post.title }}
    </a>
  </h2>
  <div class="post-date">{{ post.date | date: "%b %-d, %Y" }}</div>
  {{ post.excerpt }}
{% endfor %}
