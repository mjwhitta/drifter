# How to package box with only mounted iso

## Setup

Create your VM in VirtualBox. Then create a `Vagrantfile` and
`passwordless_sudo.sh` like those below:

### Sample `Vagrantfile`

```ruby
# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
    iso = File.expand_path("../iso_name_here.iso", __FILE__)

    # Virtualbox settings
    config.vm.provider "virtualbox" do |vb|
        # Attach specified iso file
        vb.customize [
            "storageattach",
            :id,
            "--storagectl",
            "IDE",
            "--port",
            "1",
            "--device",
            "0",
            "--type",
            "dvddrive",
            "--medium",
            iso
        ]
    end

    # Give passwordless sudo since booting from iso
    config.vm.provision "shell", run: "always" do |s|
        s.privileged = false
        s.path = File.expand_path("../passwordless_sudo.sh", __FILE__)
    end
end
```

### Sample `passwordless_sudo.sh`

```sh
#!/usr/bin/env bash

echo "username ALL=(ALL) NOPASSWD: ALL" > /tmp/username
chmod 440 /tmp/username
echo "password" | sudo -S cp /tmp/username /etc/sudoers.d/
rm /tmp/username
```

## Package box file

After the setup is finished, the box can be packaged using the
following command:

```sh
$ vagrant package \
    --vagrantfile Vagrantfile \
    --include /path/to/iso,/path/to/passwordless_sudo.sh \
    --base VMNAME
```
