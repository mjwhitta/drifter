#!/usr/bin/env bash

echo -n "Installing drifter..."

# Create user config if needed
if [ ! -f "${USER}Config.rb" ]; then
    cp DrifterConfig.rb ${USER}Config.rb
fi

# Make sure ~/bin exists and go to it
mkdir -p ~/bin && cd ~/bin

# Copy executable
if [ ! -h ~/bin/drift ]; then
    ln -s ~/.drifter/drift.rb drift
fi

echo "done!"
