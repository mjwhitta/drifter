#!/usr/bin/env bash

script="/tmp/bleeding_edge.sh"

cat > $script << EOF
#!/usr/bin/env bash

# Make sure in home dir
cd

# Update
echo "Updating..."
if [ "\$(which apt-get 2>/dev/null)" ]; then
    sudo apt-get -y update
    sudo apt-get -y upgrade
    sudo apt-get -y dist-upgrade
    sudo apt-get -y autoremove
    sudo apt-get -y autoclean
elif [ "\$(which yaourt 2>/dev/null)" ]; then
    sudo yaourt -Syua --noconfirm
elif [ "\$(which pacman 2>/dev/null)" ]; then
    sudo pacman -Syyu --noconfirm
    sudo pacman -Sc --noconfirm
elif [ "\$(which yum 2>/dev/null)" ]; then
    sudo yum update -y
fi
echo "done"
EOF

chmod a+x $script
sudo -u $1 $script
rm $script
