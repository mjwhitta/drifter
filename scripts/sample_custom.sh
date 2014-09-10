#!/usr/bin/env bash

script="/tmp/custom.sh"

cat > $script << EOF
#!/usr/bin/env bash

# Make sure in home dir
cd

# Custom installation start
echo "Starting custom installation..."

# Install git if needed
if [ ! "\$(which git 2>/dev/null)" ]; then
    if [ "\$(which apt-get 2>/dev/null)" ]; then
        sudo apt-get install git -y
    elif [ "\$(which pacman 2>/dev/null)" ]; then
        sudo pacman -S git --noconfirm
    fi
fi

# Use private key for BitBucket
echo "Host bitbucket.org" > .ssh/config
echo "IdentityFile ~/.ssh/vagrantvm" >> .ssh/config

# Add BitBucket to known_hosts
echo "blah host key blah" >> .ssh/known_hosts

# Clone my dotfiles
git clone git@bitbucket.org:username/dotfiles.git

# Install stuff
if [ "\$(which apt-get 2>/dev/null)" ]; then
    sudo apt-get -y install stuff
elif [ "\$(which pacman 2>/dev/null)" ]; then
    sudo pacman -S stuff --noconfirm
fi

# Change to zsh
sudo chsh -s /usr/bin/zsh $1

# Update locate database
sudo updatedb

# Custom installation done
echo "Done"
EOF

chmod a+x $script
sudo -u $1 $script
rm $script
