require "pathname"

class Box
    attr_accessor :box
    attr_accessor :name
    attr_accessor :url
    attr_accessor :headless
    attr_accessor :username
    attr_accessor :shared
    attr_accessor :priv_keys
    attr_accessor :pub_keys
    attr_accessor :scripts
    attr_accessor :memory
    attr_accessor :cpus
    attr_accessor :boot1
    attr_accessor :boot2
    attr_accessor :boot3
    attr_accessor :boot4
    attr_accessor :vram
    attr_accessor :accelerate3d
    attr_accessor :clipboard

    def initialize(box, name="")
        @box = box.split("/")[-1].gsub(".box", "")

        @name = name
        if (@name.empty?) then
            @name = @box.split("/")[-1].gsub(".box", "")
        end

        @url = box

        @headless = false

        @username = "vagrant"

        @shared = {"shared" => "/vagrant-shared"}

        @priv_keys = Dir["ssh-keys/*"].delete_if do |k|
            k.end_with?(".pub") || Pathname(k).directory?
        end
        @priv_keys.concat(Dir["ssh-keys/#{@name}/*"].delete_if do |k|
            k.end_with?(".pub") || Pathname(k).directory?
        end)

        @pub_keys = Dir["ssh-keys/*.pub"]
        @pub_keys.concat(Dir["ssh-keys/#{@name}/*.pub"])

        @scripts = Dir["scripts/[0-9]*.sh"]
        @scripts.concat(Dir["scripts/#{name}/[0-9]*.sh"])
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
    end
end

module DrifterConfig
    def self.load()
        boxes = Array.new

        # Create Manjaro box
        manjaro = Box.new("boxes/manjaro-0.8.9-openbox-x86_64.box",
                          "manjaro")
        manjaro.memory = "2048"
        manjaro.cpus = "2"
        boxes.push(manjaro)

        kali = Box.new("boxes/kali-1.0.6-amd64.box", "kali")
        kali.memory = "2048"
        kali.cpus = "2"
        boxes.push(kali)

        # Remove boxes that don't exist
        boxes.delete_if do |box|
            is_http = box.url.start_with?("http")
            exists_locally = Pathname.new(box.url).exist?
            (!is_http && !exists_locally)
        end

        return boxes
    end
end
