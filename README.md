# What is this?

Drifter is my attempt at a universal Vagrant setup.

# Setup

## Configuration

To start your own drifter configuration, use the following command:

```bash
cp DrifterConfig.rb ${USER}Config.rb
```

Open `${USER}Config.rb` and add box configurations to the `get()`
method. Use [DrifterConfig.rb] as an example. If the box file doesn't
exist, it will not be used. This helps with the whole universal thing.
You only need to specify the relatvie path to the box, although I
recommend you specify a name as well since you will need to use that
name later, and the default name may not be very pretty. Boxes that
are from [vagrantcloud] or some other http source will always be used
since I can't check if they exist (or rather they should always exist
if you used the right link).

[DrifterConfig.rb]: https://bitbucket.org/mjwhitta/drifter/src/master/DrifterConfig.rb
[vagrantcloud]: https://vagrantcloud.com

## SSH-key pairs

To secure your vagrant boxes you will want to create directories with
the names of your boxes in [ssh-keys]. Then put your own secure
ssh-key pairs in them. Any keys you put directly in [ssh-keys] will be
used for all boxes. You do not need to remove the vagrant insecure
ssh-key pair. That will be done for you by one of the
[scripts][authorized_keys]. Any public keys you create will be added
to `~/.ssh/authorized_keys` on the boxes. Your private keys will only
be uploaded if they end with `.upload`. I did it this way for paranoid
people. Uploading the private key is opt-in.

[authorized_keys]: https://bitbucket.org/mjwhitta/drifter/src/master/scripts/10-authorized_keys.sh
[ssh-keys]: https://bitbucket.org/mjwhitta/drifter/src/master/ssh-keys

## Provisioning scripts

To add your own provisioning scripts you will want to create
directories with the names of your boxes in [scripts]. Then put your
own scripts in them making sure to number them. They are run in
numerical order. Any scripts you put directly in [scripts] will be run
for all boxes. An example of what a custom script might look like can
be found in [sample]. All custom scripts are passed the box's username
as the first and only parameter. This allows the script to be ran as
that user instead of root.

[sample]: https://bitbucket.org/mjwhitta/drifter/src/master/scripts/sample_custom.sh
[scripts]: https://bitbucket.org/mjwhitta/drifter/src/master/scripts

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

# Special cases

If you want to use a box that only boots from an iso image, look at my
tutorial in [iso_only_box].

[iso_only_box]: https://bitbucket.org/mjwhitta/drifter/src/master/docs/iso_only_box.md
