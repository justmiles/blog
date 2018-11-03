---
title: Managing Your Linux Home
date: 2017-08-04
id: 1452133191
tags:
  - linux
---
There's no place like `~/`. 

Your home truly is a special place. It's where you eat, sleep, and store some of your most precious assets. Your unix home isn't very different. This is where you might store essentials like ssh keys and authorization tokens. While some of it can be published for the world to see, most of it should only be visible to you. After using the same machine for a little while you might amass quite a collection of config files and personal secrets. This collection is commonly called your "dotfiles". Here's how I manage my dotfiles.

<!-- more -->

## Store your dotfiles in git
If you haven't already, setup a [keybase](https://keybase.io/) account to take advantage of their free encrypted git repositories. Data you store with Keybase is encrypted and decrypted on your machine only. You're the only one who has the key required to decrypt the data. 

## Symlink your dotfiles
Create symlinks for your dotfiles from their source in git. There are several tools you can use to accomplish this but I've leaned on [deja](https://www.npmjs.com/package/deja) for a while now.

If you not sure what files should be added to a dotfiles git repo start with your `~/.ssh` directory and `~/.bashrc`.

```
    npm install -g deja
    deja clone keybase://yourusername/dotfiles
```
