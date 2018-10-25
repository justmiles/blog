#!/bin/ash

cd /blog

hexo generate --force

hexo serve --cwd /blog