require_relative "Box"
require "pathname"

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
