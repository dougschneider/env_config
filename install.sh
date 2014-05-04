#!/bin/bash
cp .bashrc ~/.envbashrc
echo "source ~/.envbashrc" >> ~/.bashrc
cp -R .vim ~/.vim
cp .vimrc ~/.vimrc
source ~/.bashrc
