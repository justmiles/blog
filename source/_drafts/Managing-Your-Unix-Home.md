---
title: Managing Your Linux Home
date: 2016-10-31
id: 1452133191
tags:
  - linux
categories:
  - uncategorized
---
There's no place like `~/`. 

Your home truly is a special place. It's where you eat, sleep, and store some of your most precious assets. Your unix home isn't very different. This is where you might store essentials like bash configs or ssh keys. While some of it can be published for the world to see, most of it should only be visible to you. After using the same machine for a little while you might amass quite a collection of config file and personal secrets. This collection is commonly called your "dotfiles" - and here's a good practice for managing them.

<!-- more -->

Treat your dotfiles as git repos

Use a method that supports multiple dotfile repositories

Keep private dotfiles in a private repo