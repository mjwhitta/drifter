require "pathname"

class Box
    attr_accessor :accelerate3d
    attr_accessor :boot1
    attr_accessor :boot2
    attr_accessor :boot3
    attr_accessor :boot4
    attr_accessor :box
    attr_accessor :clipboard
    attr_accessor :cpus
    attr_accessor :headless
    attr_accessor :iso
    attr_accessor :memory
    attr_accessor :name
    attr_accessor :password
    attr_accessor :priv_keys
    attr_accessor :pub_keys
    attr_accessor :scripts
    attr_accessor :shared
    attr_accessor :url
    attr_accessor :username
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
    end
end

module DrifterConfig
    def self.load()
        boxes = Array.new

        #######################################
        ### Create and add boxes below here ###
        #######################################

        # Create Manjaro box
        manjaro = Box.new("boxes/manjaro-0.8.9-openbox-x86_64.box",
                          "manjaro")
        manjaro.memory = "2048"
        manjaro.cpus = "2"
        #boxes.push(manjaro)

        # Create Nebula box
        nebula = Box.new("boxes/nebula.box")
        nebula.headless = true
        nebula.username = "nebula"
        nebula.password = "nebula"
        nebula.priv_keys = nil
        nebula.pub_keys = nil
        nebula.scripts = nil
        nebula.shared = nil
        nebula.memory = "512"
        nebula.boot2 = "none"
        boxes.push(nebula)

        # Create Protostar box
        protostar = Box.new("boxes/protostar.box")
        protostar.headless = true
        protostar.username = "user"
        protostar.password = "user"
        protostar.priv_keys = nil
        protostar.pub_keys = nil
        protostar.scripts = nil
        protostar.shared = nil
        protostar.memory = "512"
        protostar.boot2 = "none"
        boxes.push(protostar)

        # Create Fusion box
        fusion = Box.new("boxes/fusion.box")
        fusion.headless = true
        fusion.username = "fusion"
        fusion.password = "godmode"
        fusion.priv_keys = nil
        fusion.pub_keys = nil
        fusion.scripts = nil
        fusion.shared = nil
        fusion.memory = "512"
        fusion.boot2 = "none"
        boxes.push(fusion)

        #######################################
        ### Create and add boxes above here ###
        #######################################

        # Remove boxes that don't exist
        boxes.delete_if do |box|
            is_http = box.url.start_with?("http")
            exists_locally = Pathname.new(box.url).exist?
            (!is_http && !exists_locally)
        end

        return boxes
    end
end
