# What is this?

Drifter is my attempt at a universal Vagrant setup.

# Setup

## Installation

```bash
$ cd && git clone https://gitlab.com/mjwhitta/drifter.git .drifter
$ cd .drifter && ./install.sh
```

## Configuration

Open `~/.drifter/${USER}Config.rb` and add box configurations to the
`get()` method. Use [DrifterConfig.rb](DrifterConfig.rb) as an
example. If the box file doesn't exist, it will not be used. This
helps with the whole universal thing. You only need to specify the
relative path to the box, although I recommend you specify a name as
well since you will need to use that name later, and the default name
may not be very pretty. Boxes that are from [vagrantcloud] or some
other http source will always be used since I can't check if they
exist (or rather they should always exist if you used the right link).

[vagrantcloud]: https://vagrantcloud.com

## SSH-key pairs

To secure your vagrant boxes you will want to create directories with
the names of your boxes in [ssh-keys](ssh-keys). Then put your own
secure ssh-key pairs in them. Any keys you put directly in [ssh-keys]
will be used for all boxes. You do not need to remove the vagrant
insecure ssh-key pair. That will be done for you by one of the
[scripts](scripts/10-authorized_keys.sh). Any public keys you create
will be added to `~/.ssh/authorized_keys` on the boxes. Your private
keys will only be uploaded if they end with `.upload`. I did it this
way for paranoid people. Uploading the private key is opt-in.

## Provisioning scripts

To add your own provisioning scripts you will want to create
directories with the names of your boxes in [scripts](scripts). Then
put your own scripts in them making sure to number them. They are run
in numerical order. Any scripts you put directly in [scripts](scripts)
will be run for all boxes. An example of what a custom script might
look like can be found in [sample](scripts/sample_custom.sh). All
custom scripts are passed the box's username as the first and only
parameter. This allows the script to be ran as that user instead of
root.

# Usage

Create your configuration file, then use the following command:

```bash
$ drift up
```

You can start from scratch by using the following commands:

```bash
$ drift destroy
$ drift up
```

All `vagrant` commands will work. `drift` is just a ruby wrapper for
`vagrant` that executes commands from the `~/.drifter` directory.

# Special cases

If you want to use a box that only boots from an iso image, look at my
tutorial in [iso_only_box](docs/iso_only_box.md).
