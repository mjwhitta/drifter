require "pathname"

class Box
    # string - on/off, 3D graphics enabled
    attr_accessor :accelerate3d

    # string - disk/dvd/none, boot order
    attr_accessor :boot1
    attr_accessor :boot2
    attr_accessor :boot3
    attr_accessor :boot4

    # string - box name in vagrant
    attr_accessor :box

    # string - Bidirectional/Disabled
    attr_accessor :clipboard

    # integer - technically string, number of cpus
    attr_accessor :cpus

    # hash of integer to integer - forward_ports[guest] = host
    attr_accessor :forward_ports

    # boolean - run headless or not
    attr_accessor :headless

    # string - path to iso file, used for mounting a local iso
    # NOTE: If you packaged an iso in your box, you will also need to
    # package a Vagrantfile that mounts the iso b/c that can't be done
    # here
    attr_accessor :iso

    # integer - technically string, RAM in MB
    attr_accessor :memory

    # string - name that shows in VirtualBox
    attr_accessor :name

    # string - ssh password
    attr_accessor :password

    # array of string - list of private keys to use
    attr_accessor :priv_keys

    # string - IP address on private network
    attr_accessor :private_ip

    # array of string - list of public keys to upload
    attr_accessor :pub_keys

    # boolean - should box have a public IP address
    attr_accessor :public

    # array of string - list of provisioning scripts
    attr_accessor :scripts

    # hash of string to string - shared[local] = remote
    attr_accessor :shared

    # string - where to get box, url or filepath
    attr_accessor :url

    # string - ssh username
    attr_accessor :username

    # integer - technically string, VRAM in MB
    attr_accessor :vram

    def initialize(box, name="")
        @accelerate3d = "on"

        @boot1 = "dvd"

        @boot2 = "disk"

        @boot3 = "none"

        @boot4 = "none"

        @box = box.split("/")[-1].gsub(".box", "")

        @clipboard = "Bidirectional"

        @cpus = "1"

        @forward_ports = Hash.new

        @headless = false

        @iso = nil

        @memory = "1024"

        @name = name
        if (@name.empty?) then
            @name = @box
        end

        @password = nil

        @priv_keys = Dir["ssh-keys/*"].delete_if do |k|
            k.end_with?(".pub") || Pathname(k).directory?
        end
        @priv_keys.concat(Dir["ssh-keys/#{@name}/*"].delete_if do |k|
            k.end_with?(".pub") || Pathname(k).directory?
        end)

        @private_ip = nil

        @pub_keys = Dir["ssh-keys/*.pub"]
        @pub_keys.concat(Dir["ssh-keys/#{@name}/*.pub"])

        @public = false

        @scripts = Dir["scripts/[0-9]*.sh"]
        @scripts.concat(Dir["scripts/#{@name}/[0-9]*.sh"])
        @scripts.sort! do |a, b|
            a.split("/")[-1] <=> b.split("/")[-1]
        end

        @shared = {"shared" => "/vagrant-shared"}

        @url = box

        @username = "vagrant"

        @vram = "64"
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

        @shared = clear
    end
end
