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
        manjaro = Box.new("boxes/manjaro-openbox-0.8.10-x86_64.box",
                          "manjaro")
        manjaro.cpus = "2"
        manjaro.memory = "2048"
        boxes.push(manjaro)

        # Create Kali box
        kali = Box.new("boxes/kali-linux-1.0.7-amd64.box", "kali")
        kali.cpus = "2"
        kali.memory = "2048"
        kali.username = "root"
        boxes.push(kali)

        # Create Nebula box
        nebula = Box.new("boxes/nebula.box")
        nebula.headless = true
        nebula.memory = "512"
        nebula.password = "nebula"
        nebula.set_iso_only
        nebula.username = "nebula"
        boxes.push(nebula)

        # Create Protostar box
        protostar = Box.new("boxes/protostar.box")
        protostar.headless = true
        protostar.memory = "512"
        protostar.password = "godmode"
        protostar.set_iso_only
        protostar.username = "root"
        boxes.push(protostar)

        # Create Fusion box
        fusion = Box.new("boxes/fusion.box")
        fusion.headless = true
        fusion.memory = "512"
        fusion.password = "godmode"
        fusion.set_iso_only
        fusion.username = "fusion"
        boxes.push(fusion)

        # Create DevStack box
        devstack = Box.new("boxes/devstack.box")
        devstack.cpus = "4"
        devstack.forward_ports[80] = 8080
        devstack.memory = "4098"
        devstack.scripts.clear
        devstack.username = "user"
        boxes.push(devstack)

        #######################################
        ### Create and add boxes above here ###
        #######################################

        return existing_boxes(boxes)
    end
end
