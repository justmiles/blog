#!/bin/bash

source ~/.nvm/nvm.sh
nvm use lts/boron

which hexo > /dev/null 2>&1 || npm install hexo-cli -g