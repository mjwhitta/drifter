#!/usr/bin/env bash

script="/tmp/authorized_keys.sh"

cat > $script << EOF
#!/usr/bin/env bash

# Make sure in home dir
cd

# Fix authorized_keys to contain any ssh-keys that were uploaded
# with file provisioner except for vagrant insecure keys
if [ -d .ssh/ ]; then
    cd .ssh/

    # Only do this if user provided secure keys
    if [ "\$(\ls *.pub | \grep -v vagrant.pub)" ]; then
        echo "Removing vagrant's insecure keys..."
        rm -f vagrant vagrant.pub
        echo "Adding user's keys..."
        cat *.pub > authorized_keys

        # Fix permissions
        echo "Fixing permissions..."
        sudo chown -R vagrant:users .
        chmod 600 *
        echo "Done"
    fi
else
    echo "Something went wrong uploading ssh-keys!"
fi
EOF

chmod a+x $script
sudo -u $1 $script
rm $script
