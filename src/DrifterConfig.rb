require_relative "Box"
require "pathname"

module DrifterConfig
    def self.existing_boxes(boxes)
        # Remove boxes that don't exist
        boxes.delete_if do |box|
            is_http = box.url.start_with?("http")
            exists_locally = Pathname.new(box.url).exist?
            (!is_http && !exists_locally)
        end

        return boxes
    end

    def self.load()
        boxes = Array.new

        #######################################
        ### Create and add boxes below here ###
        #######################################

        # Create Manjaro box
        manjaro = Box.new("boxes/manjaro-0.8.10-openbox-x86_64.box",
                          "manjaro")
        manjaro.memory = "2048"
        manjaro.cpus = "2"
        boxes.push(manjaro)

        # Create Kali box
        kali = Box.new("boxes/kali-linux-1.0.7-amd64.box", "kali")
        kali.username = "root"
        kali.memory = "2048"
        kali.cpus = "2"
        boxes.push(kali)

        # Create Nebula box
        nebula = Box.new("boxes/nebula.box")
        nebula.headless = true
        nebula.username = "nebula"
        nebula.password = "nebula"
        nebula.set_iso_only
        nebula.memory = "512"
        nebula.boot2 = "none"
        boxes.push(nebula)

        # Create Protostar box
        protostar = Box.new("boxes/protostar.box")
        protostar.headless = true
        protostar.username = "user"
        protostar.password = "user"
        protostar.set_iso_only
        protostar.memory = "512"
        protostar.boot2 = "none"
        boxes.push(protostar)

        # Create Fusion box
        fusion = Box.new("boxes/fusion.box")
        fusion.headless = true
        fusion.username = "fusion"
        fusion.password = "godmode"
        fusion.set_iso_only
        fusion.memory = "512"
        fusion.boot2 = "none"
        boxes.push(fusion)

        #######################################
        ### Create and add boxes above here ###
        #######################################

        return existing_boxes(boxes)
    end
end
