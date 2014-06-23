require "pathname"

class Box
    # string - on/off, 3D graphics enabled
    attr_accessor :accelerate3d

    # string - disk/dvd/none
    attr_accessor :boot1
    attr_accessor :boot2
    attr_accessor :boot3
    attr_accessor :boot4

    # string - box name
    attr_accessor :box

    # string - Bidirectional/Disabled
    attr_accessor :clipboard

    # integer - technically string
    attr_accessor :cpus

    # boolean
    attr_accessor :headless

    # string - path to iso file
    attr_accessor :iso

    # integer - technically string, RAM in MB
    attr_accessor :memory

    # string - name in VirtualBox
    attr_accessor :name

    # string - ssh password
    attr_accessor :password

    # array of string
    attr_accessor :priv_keys

    # string - IP address on private network
    attr_accessor :private_ip

    # array of string
    attr_accessor :pub_keys

    # boolean - on public network
    attr_accessor :public

    # array of string
    attr_accessor :scripts

    # hash of string to string
    attr_accessor :shared

    # string - where to get box
    attr_accessor :url

    # string - ssh username
    attr_accessor :username

    # integer - technically string, VRAM in MB
    attr_accessor :vram

    def initialize(box, name="")
        # Name for the box
        @box = box.split("/")[-1].gsub(".box", "")

        # Name that shows up in Virtualbox
        @name = name
        if (@name.empty?) then
            @name = @box.split("/")[-1].gsub(".box", "")
        end

        # URL or file path to box file
        @url = box

        # Don't run headless by default
        @headless = false

        # SSH username and password
        @username = "vagrant"
        @password = nil

        # Shared folders
        @shared = {"shared" => "/vagrant-shared"}

        # List of private keys
        @priv_keys = Dir["ssh-keys/*"].delete_if do |k|
            k.end_with?(".pub") || Pathname(k).directory?
        end
        @priv_keys.concat(Dir["ssh-keys/#{@name}/*"].delete_if do |k|
            k.end_with?(".pub") || Pathname(k).directory?
        end)

        # List of public keys
        @pub_keys = Dir["ssh-keys/*.pub"]
        @pub_keys.concat(Dir["ssh-keys/#{@name}/*.pub"])

        # List of scripts to run when provisioning
        @scripts = Dir["scripts/[0-9]*.sh"]
        @scripts.concat(Dir["scripts/#{@name}/[0-9]*.sh"])
        @scripts.sort! do |a, b|
            a.split("/")[-1] <=> b.split("/")[-1]
        end

        @memory = "1024"
        @cpus = "1"
        @boot1 = "dvd"
        @boot2 = "disk"
        @boot3 = "none"
        @boot4 = "none"
        @vram = "64"
        @accelerate3d = "on"
        @clipboard = "Bidirectional"

        # Used for mounting a local iso. If you packaged an iso in
        # your box, you will also need to package a Vagrantfile that
        # mounts the iso b/c that can't be done here.
        @iso = nil

        # Default to not on public network
        @public = false

        # Default to not on private network
        @private_ip = nil
    end

    def set_iso_only()
        to_delete = Dir["ssh-keys/*"].delete_if do |k|
            k.end_with?(".pub") || Pathname(k).directory?
        end
        @priv_keys.delete_if do |key|
            to_delete.include?(key)
        end

        to_delete = Dir["ssh-keys/*.pub"]
        @pub_keys.delete_if do |key|
            to_delete.include?(key)
        end

        to_delete = Dir["scripts/[0-9]*.sh"]
        @scripts.delete_if do |script|
            to_delete.include?(script)
        end

        @shared = nil
    end
end
