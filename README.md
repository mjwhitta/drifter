# What is this?

Drifter is my attempt at a universal Vagrant setup.

# Setup

## SSH-key pairs

You can add box configurations to the `load()` method in
`DrifterConfig.rb`. If the box file doesn't exist, it will not be
used. This helps with the whole universal thing. You only need to
specify the relatvie path to the box, although I recommend you specify
a name as well since you will need to use that name later, and the
default name may not be very pretty.

To secure your vagrant boxes you will want to create directories with
the names of your boxes in [ssh-keys]. Then put your own secure
ssh-key pairs in them. You do not need to remove the vagrant insecure
ssh-key pair. That will be done for you by one of the
[scripts][authorized_keys]. Any public keys you create will be added
to `~/.ssh/authorized_keys` on the boxes. Your private keys will only
be uploaded if they end with `.upload`. I did it this way for paranoid
people. Uploading the private key is opt-in.

## Provisioning scripts

To add your own provisioning scripts you will want to create
directories with the names of your boxes in [scripts]. Then put your
own scripts in them making sure to number them. They are run in
numerical order. An example of what a custom script might look like
can be found in [sample]. All custom scripts are passed the box's
username as the first and only parameter. This allows the script to be
ran as that user instead of root.

[authorized_keys]: src/master/scripts/10-authorized_keys.sh
[sample]: src/master/scripts/sample_custom.sh
[scripts]: src/master/scripts
[ssh-keys]: src/master/ssh-keys

# Usage

Modify `DrifterConfig.rb`, then use the following command:

```sh
    $ vagrant up
```

You can start from scratch by using the following commands:

```sh
    $ vagrant destroy
    $ vagrant up
```
