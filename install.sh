#!/usr/bin/env bash

usage() {
    echo "Usage: ${0/*\//} [install_dir]"
    echo "Options:"
    echo "    -h"
    echo "        Display this help message"
    echo
    exit $1
}

if [ $# -gt 1 ]; then
    usage 1
fi

INSTALL_DIR="$HOME/bin"
case "$1" in
    "-h"|"--help") usage 0
        ;;
    *)
        if [ "$1" ]; then
            INSTALL_DIR="$1"
        fi
        ;;
esac

echo -n "Installing drifter..."

# Create user config if needed
if [ ! -f "${USER}Config.rb" ]; then
    cp DrifterConfig.rb ${USER}Config.rb
fi

# Save install location
cwd=$(pwd)

# Make sure ~/bin exists and go to it
mkdir -p $INSTALL_DIR && cd $INSTALL_DIR

# Copy
cp $cwd/drift.sh drift

echo "done!"
