# How to package box with only mounted iso

## Setup

Create your VM in VirtualBox. Then create a Vagrant file like the one
in the next section. When you are ready, run the following command:

```sh
$ vagrant package --vagrantfile Vagrantfile --include /path/to/iso --base VMNAME
```

## Sample Vagrantfile

```ruby
# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
    iso = File.expand_path("../iso_name_here.iso", __FILE__)

    # Virtualbox settings
    config.vm.provider "virtualbox" do |vb|
        # Attach any specified iso files
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
end
```
