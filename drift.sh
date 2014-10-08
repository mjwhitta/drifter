#!/usr/bin/env bash

if [ ! -d ~/.drifter ]; then
    echo "Drifter is not installed!"
    exit 1
fi

\cd ~/.drifter

if [ ! "$(command -v vagrant)" ]; then
    echo "Vagrant is not installed!"
    exit 2
fi

vagrant $@
